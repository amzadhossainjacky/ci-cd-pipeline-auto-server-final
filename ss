node {
    def appDir = '/var/www/html/nextjs-app'

    stage('Clean Workspace'){
        echo 'Cleaning Jenkins Workspace'
        deleteDir()
    }

    stage('Clone Repo'){
        echo 'Cloning the repo'
        git(
            branch: 'master',
            url: 'https://github.com/amzadhossainjacky/ci-cd-pipeline-auto-deploy-server'
        )
    }

    stage('Deploy to Dedicated Server') {
    echo 'Deploying to Dedicated Server'

    sh """
        set -e

        sudo mkdir -p ${appDir}
        sudo chown -R jenkins:jenkins ${appDir}

        rsync -av --delete --exclude='.git' --exclude='node_modules' ./ ${appDir}

        cd ${appDir}

        npm install
        npm run build

        # ✅ use full pm2 path
        # /usr/local/bin/pm2 delete nextjs-app || true
        # /usr/local/bin/pm2 kill || true

        # PORT=3000 HOSTNAME=0.0.0.0 /usr/local/bin/pm2 start npm --name "nextjs-app" -- start

        # /usr/local/bin/pm2 save
    """
    
}

stage('Service created'){
    echo 'Service created'

    sh '''
        set -e

        sudo bash -c 'cat > /etc/systemd/system/nextjs-app.service <<EOF
[Unit]
Description=Next.js App
After=network.target

[Service]
Type=simple
User=jenkins
WorkingDirectory=/var/www/html/nextjs-app
ExecStart=/usr/bin/npm start
Restart=always
Environment=PORT=3000
Environment=HOSTNAME=0.0.0.0

[Install]
WantedBy=multi-user.target
EOF'

        sudo systemctl daemon-reload
        sudo systemctl enable nextjs-app
        sudo systemctl restart nextjs-app
    '''
}
}