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

        """
        
    }

    stage('Service created'){
        echo 'Service created'

        sh """
            set -e

            sudo bash -c 'cat > /etc/systemd/system/nextjs-app.service <<EOF
            [Unit]
            Description=Next.js App
            After=network.target

            [Service]
            Type=simple
            User=jenkins
            WorkingDirectory=/var/www/html/nextjs-app

            # ✅ Use full path of npm
            ExecStart=/usr/bin/npm run start

            # ✅ Restart policy
            Restart=always
            RestartSec=5

            # ✅ Environment variables
            Environment=PORT=3000
            Environment=HOST=0.0.0.0

            # ✅ Fix PATH issue
            Environment=PATH=/usr/bin:/usr/local/bin

            [Install]
            WantedBy=multi-user.target
            EOF'

            sudo systemctl daemon-reload
            sudo systemctl enable nextjs-app
            sudo systemctl start nextjs-app
            """

    }
}