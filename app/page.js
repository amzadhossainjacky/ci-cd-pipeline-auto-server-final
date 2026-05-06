import Image from "next/image";

export default function Home() {
  return (
    <div className="flex flex-col flex-1 items-center justify-center bg-zinc-50 font-sans dark:bg-black">
      <main className="flex flex-1 w-full max-w-3xl flex-col items-center justify-between py-32 px-16 bg-white dark:bg-black sm:items-start">
        <h1 className="text-5xl font-bold text-center sm:text-left">
          Welcome to{" "}
          <a
            href="https://nextjs.org"
            className="text-blue-600 dark:text-blue-400 hover:underline" 
          >
            CI CD with Jenkins and Next.js !! Jacky the great  works hard to make this project successful.
            2026 will be lengary year in ai and devops world. Let's make it happen together.

          </a>
        </h1>
        <p className="mt-4 text-2xl text-center sm:text-left">
          Get started by editing{" "}
          <code className="bg-gray-100 dark:bg-gray-800 rounded px-1 py-0.5 text-sm font-mono">
            Awesome Next.js CI/CD Pipeline with Jenkins
          </code>
        </p>
      </main>
    </div>
  );
}
