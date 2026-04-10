<div align="center">

# 🦉 Athena

**A full-stack productivity and focus tracking app — built end-to-end with a real DevOps pipeline.**

*Track your focus. Understand your habits. Ship like a pro.*

<br/>

![JavaScript](https://img.shields.io/badge/JavaScript-F7DF1E?style=for-the-badge&logo=javascript&logoColor=black)
![React](https://img.shields.io/badge/React-20232A?style=for-the-badge&logo=react&logoColor=61DAFB)
![Vite](https://img.shields.io/badge/Vite-646CFF?style=for-the-badge&logo=vite&logoColor=white)
![TailwindCSS](https://img.shields.io/badge/Tailwind_CSS-38B2AC?style=for-the-badge&logo=tailwind-css&logoColor=white)
![Node.js](https://img.shields.io/badge/Node.js-339933?style=for-the-badge&logo=nodedotjs&logoColor=white)
![Express.js](https://img.shields.io/badge/Express.js-000000?style=for-the-badge&logo=express&logoColor=white)
![MongoDB](https://img.shields.io/badge/MongoDB-47A248?style=for-the-badge&logo=mongodb&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)
![Kubernetes](https://img.shields.io/badge/Kubernetes-326CE5?style=for-the-badge&logo=kubernetes&logoColor=white)
![Terraform](https://img.shields.io/badge/Terraform-7B42BC?style=for-the-badge&logo=terraform&logoColor=white)
![Ansible](https://img.shields.io/badge/Ansible-EE0000?style=for-the-badge&logo=ansible&logoColor=white)
![GitHub Actions](https://img.shields.io/badge/GitHub_Actions-2088FF?style=for-the-badge&logo=github-actions&logoColor=white)

</div>

---

## What is Athena?

Athena is a productivity app that helps you track deep work sessions, manage tasks, and understand your own work patterns through a rich analytics dashboard. But the app is only half the story.

Behind it is a complete DevOps pipeline — containerized with Docker, orchestrated with Kubernetes, provisioned with Terraform, automated with Ansible, and shipped through GitHub Actions CI/CD. Every layer of the modern software lifecycle is here, not just talked about.

---

## Features

**For users:**
- 🎯 **Focus Session Timer** — Start, pause, and log deep work sessions with notes and mood tracking
- 📊 **Analytics Dashboard** — Visualize focus vs break time, mood trends, completion rates, distraction patterns, and more across 9+ chart types
- ✅ **Task & Goal Management** — Plan your work and track progress toward goals
- 🔥 **Streak Tracking** — Build and maintain daily consistency habits
- 📓 **In-Session Notes** — Capture thoughts without breaking your flow
- 💡 **Today's Insights** — AI-generated summaries of your productivity day
- 🌙 **Dark / Light Mode** — Because it matters

**Under the hood:**
- Role-based access control (user + admin)
- JWT authentication with OTP email verification
- Session recovery on page refresh
- Horizontal scaling via Kubernetes replicas
- Automated deployment with Ansible playbooks

---

## Architecture

```
Browser
  └── React + Vite Frontend  (Tailwind CSS, Context API, custom hooks)
        └── Node.js + Express Backend  (MVC + Service layer)
              └── MongoDB  (sessions, tasks, goals, streaks, daily stats)
```

All three layers run as containers — locally via Docker Compose, and orchestrated via Kubernetes.

---

## Project Structure

```
Athena/
├── frontend/
│   ├── src/
│   │   ├── pages/
│   │   │   ├── user/
│   │   │   │   ├── dashboard/      # 9+ analytics charts, KPI cards, streak ring
│   │   │   │   ├── focus/          # Timer, session state machine, notes, hooks
│   │   │   │   ├── planner/        # Task planning view
│   │   │   │   └── profile/
│   │   │   ├── admin/              # Admin dashboard
│   │   │   └── common/auth/        # Sign in, sign up, OTP, password reset
│   │   └── components/             # Shared UI components
│   ├── contexts/                   # AuthContext, ThemeContext
│   └── services/                   # API service layer (per module)
│
├── backend/
│   ├── controllers/                # Route handlers (auth, sessions, tasks, goals…)
│   ├── services/                   # Business logic layer
│   ├── models/                     # Mongoose schemas
│   ├── routes/                     # Express routers
│   ├── middlewares/                # Auth, validation, role checks
│   └── utils/                      # Insights generator, session transformer, quotes API
│
├── k8s/                            # Kubernetes manifests (deployments + services)
├── terraform/                      # Infrastructure as Code (main, variables, outputs)
├── ansible/                        # Deployment automation playbook
└── .github/workflows/              # CI/CD pipeline
```

---

## Backend Design

The backend follows a clean **MVC + Service** pattern. Controllers handle routing, services contain all business logic, and models define the data shape. Nothing bleeds into where it shouldn't.

Key modules:

| Module | What it does |
|--------|-------------|
| `authService` | JWT auth, OTP email verification, password reset |
| `sessionService` | Computes productivity scores, focus trends, session statistics |
| `streakService` | Tracks and updates daily streaks |
| `generateInsights` | Produces human-readable daily summaries from raw session data |
| `transformSessionForDashboard` | Shapes raw DB documents into chart-ready structures |
| `adaptiveTarget` | Adjusts daily focus targets based on recent performance |
| `changeStream` | MongoDB change streams for real-time data updates |

---

## Running Locally

### Option 1 — Docker Compose (quickest)

```bash
# Clone the repo
git clone https://github.com/YOUR_USERNAME/athena.git
cd athena

# Start everything (frontend + backend + MongoDB)
docker-compose up --build
```

Open [http://localhost:5173](http://localhost:5173) for the app and [http://localhost:5000](http://localhost:5000) for the API.

---

### Option 2 — Kubernetes (Docker Desktop)

For the full orchestrated setup locally:

```bash
# 1. Enable Kubernetes in Docker Desktop settings

# 2. Build images
docker build -t athena-backend ./backend
docker build -t athena-frontend ./frontend

# 3. Apply all manifests
kubectl apply -f k8s/

# 4. Access the app
kubectl port-forward service/frontend 8080:5173
```

Open [http://localhost:8080](http://localhost:8080).

The backend deployment is configured with multiple replicas — so you're running a horizontally scaled setup, not just a single pod. Inter-service communication uses Kubernetes service names instead of localhost, which is how it works in a real cluster.

---

## CI/CD Pipeline

Every push to `main` triggers the GitHub Actions workflow:

```
Push to main
  └── Build Docker images  (frontend + backend)
        └── Validate Kubernetes manifests
```

Nothing ships unless the build is clean and the configs are valid. Workflow file: `.github/workflows/deploy.yml`

---

## Infrastructure as Code (Terraform)

Cloud infrastructure is defined in code — no clicking around in dashboards, no undocumented manual steps.

```bash
cd terraform
terraform init
terraform validate
```

Configuration is ready to extend for full cloud deployment.

---

## Deployment Automation (Ansible)

Ansible applies the Kubernetes configs automatically — consistent, repeatable, auditable.

```bash
cd ansible
ansible-playbook deploy.yml
```

---

## Tech Stack

| Layer | Technology |
|-------|-----------|
| Frontend | React, Vite, Tailwind CSS |
| State Management | Context API (Auth, Theme) |
| Backend | Node.js, Express.js |
| Database | MongoDB (Mongoose) |
| Auth | JWT + OTP email verification |
| Containers | Docker, Docker Compose |
| Orchestration | Kubernetes |
| CI/CD | GitHub Actions |
| Infrastructure | Terraform |
| Automation | Ansible |

---

## Screenshots

> Coming soon — the dashboard, focus timer, Kubernetes pods, and GitHub Actions run.

---

## What This Project Taught Me

Building Athena meant thinking beyond "does the feature work" — it forced me to think about how software actually lives in production:

- **Docker** showed me how to isolate environments and make deployments reproducible across machines
- **Kubernetes** taught me how services discover each other (using service names, not localhost), and what it actually means to scale horizontally
- **GitHub Actions** removed human error from the build process — if it breaks, the pipeline catches it before anyone else does
- **Terraform** made infrastructure something you can version, review, and roll back — not something you set up once and hope for the best
- **Ansible** turned a multi-step deployment into a single command

Athena is a real working application that also happens to demonstrate what a modern DevOps lifecycle looks like from end to end.
