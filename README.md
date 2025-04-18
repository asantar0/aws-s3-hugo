# Status page with Hugo Website on AWS S3

This project is a static website built with [Hugo](https://gohugo.io/), a fast and flexible static site generator written in Go. The site is deployed and hosted on **Amazon S3**, taking advantage of its scalability and low-cost storage for static assets.

CState is an open-source status page template built with Hugo. It's designed to help you create a simple, beautiful, and static status page — ideal for showing the current uptime of your services, listing past incidents, and sharing maintenance updates.

It works just like the status pages used by GitHub, Cloudflare, or Atlassian — but it's free, self-hosted, and doesn’t require a backend. Everything is rendered as static HTML, CSS, and JS.

## 📈 What Can You Do with CState?
- Display real-time service status (e.g., operational, degraded, down).
- Publish incident history and updates.
- Customize the UI and theming.
- Integrate deployments with GitHub Actions, GitLab CI, etc.
- Host your status page anywhere static files are supported (S3, GitHub Pages, Netlify, etc.)

## 🚀 Features

- ⚡ Built with Hugo for lightning-fast performance
- ☁️ Hosted on Amazon S3 with static website hosting enabled
- 🔁 CI/CD ready (GitHub Actions)
- 📂 Clean and organized content structure
- 🟢 It’s cost-effective and scales automatically.
- 🧘 No backend or server management needed.


## 📁 Project Structure

├── archetypes/         -> Hugo content archetypes  
├── content/            -> Markdown content files    
├── layouts/            -> Custom layout templates  
├── static/             -> Static assets (images, CSS, JS)  
├── themes/             -> Hugo themes  
├── config.yml          -> Hugo site configuration  
└── terraform/          -> IaC for AWS and Cloudflare


## 🛠️ Requirements

- [Hugo](https://gohugo.io/getting-started/installing/) installed
- [AWS CLI](https://aws.amazon.com/cli/) configured with proper credentials
- An S3 bucket with static website hosting enabled 


## 🧪 Development Workflow
First of all, it's necessary to create our infraestructure in order to deploy CState page in AWS S3. In order to accomplish this goal, you need to do the following steps

```
$ git clone git@github.com:asantar0/aws-s3-hugo.git

$ cd terraform

$ terraform apply
```

After, you need to configure Secrets in "Actions and variables" and create a "IAM_ROLE_ARN" variable.

Wrapping up, every single change that appears in folders "content", "layouts" and "static" will trigger a github actions plan.


## 🙌 Acknowledgments

- Hugo
- AWS S3
- Cstate


## 📄 License
This project is open-source and available under the MIT License.


## 📬 Contact
For questions or feedback, feel free to reach out or open an issue.