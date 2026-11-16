# 📊 Employee Attrition Dashboard

A modern, interactive employee analytics dashboard designed to analyze workforce attrition, identify employee turnover patterns, and help HR teams make data-driven workforce decisions.

## 📌 1. Project Overview

The **Employee Attrition Dashboard** is a web-based analytics application that helps organizations understand employee turnover and workforce trends.

It transforms employee data into meaningful visual insights, allowing HR professionals and management teams to monitor attrition rates, identify potential risk factors, and improve employee retention strategies.

### 🎯 Objectives

- Monitor overall employee attrition rates.
- Analyze employee demographics and workforce distribution.
- Identify departments with high employee turnover.
- Understand factors influencing employee attrition.
- Support data-driven HR decision-making.

### 👥 Target Users

- HR Managers
- HR Analysts
- Business Analysts
- Department Managers
- Organizational Leadership

## ✨ 2. Key Features

- **Interactive Dashboard:** View important workforce KPIs and analytics.
- **Attrition Analysis:** Monitor employee exits and attrition percentages.
- **Department Analysis:** Compare attrition across different departments.
- **Demographic Analysis:** Analyze employee age, gender, education, and marital status.
- **Job Satisfaction Analysis:** Explore the relationship between job satisfaction and employee retention.
- **Salary Analysis:** Understand compensation patterns among employees.
- **Experience Analysis:** Examine attrition based on years at the company.
- **Dynamic Filtering:** Filter reports by department, gender, job role, and other attributes.
- **Data Export:** Download analytical reports in CSV or Excel format.
- **Responsive Design:** Access dashboards across desktop and tablet devices.

## 🛠️ 3. Technology Stack

| Category | Technology |
|---|---|
| Frontend | React.js |
| Programming | JavaScript / TypeScript |
| Styling | Tailwind CSS |
| Charts | Recharts / Chart.js |
| Backend | Node.js |
| API Framework | Express.js |
| Database | PostgreSQL |
| Data Processing | Python, Pandas |
| Authentication | JWT (optional) |
| Version Control | Git & GitHub |
| Deployment | Vercel / Render |
| Database Hosting | Supabase / PostgreSQL Hosting |

*Note: This is a proposed reference architecture. Replace technologies with the tools actually used in your implementation.*

## 📂 4. Project Structure

```text
employee-attrition-dashboard/
│
├── frontend/
│   ├── public/
│   ├── src/
│   │   ├── components/
│   │   ├── pages/
│   │   ├── charts/
│   │   ├── services/
│   │   ├── hooks/
│   │   └── App.jsx
│   ├── package.json
│   └── vite.config.js
│
├── backend/
│   ├── controllers/
│   ├── routes/
│   ├── models/
│   ├── middleware/
│   ├── config/
│   ├── server.js
│   └── package.json
│
├── database/
│   ├── schema.sql
│   └── seed.sql
│
├── data/
│   └── employee_attrition.csv
│
├── tests/
├── .env.example
├── .gitignore
└── README.md
```

## ⚙️ 5. Installation & Setup

### Prerequisites

Install the following before starting:

- Node.js (v20 or later)
- npm
- PostgreSQL (v15 or later)
- Git

### Step 1: Clone Repository

```bash
git clone https://github.com/yourusername/employee-attrition-dashboard.git

cd employee-attrition-dashboard
```

### Step 2: Install Frontend Dependencies

```bash
cd frontend
npm install
```

### Step 3: Install Backend Dependencies

```bash
cd ../backend
npm install
```

### Step 4: Configure Environment Variables

Create a `.env` file inside the backend directory.

```env
PORT=5000
DATABASE_URL=postgresql://postgres:password@localhost:5432/employee_attrition
JWT_SECRET=your_secure_secret
NODE_ENV=development
```

### Step 5: Configure Database

Create a PostgreSQL database:

```sql
CREATE DATABASE employee_attrition;
```

Execute the database schema:

```bash
psql -U postgres -d employee_attrition -f database/schema.sql
```

### Step 6: Start Application

Start the backend:

```bash
cd backend
npm run dev
```

Start the frontend in another terminal:

```bash
cd frontend
npm run dev
```

Open the application:

```text
http://localhost:5173
```

## 📈 6. Dashboard Modules

| Module | Description |
|---|---|
| Overview | Total employees, attrition count, attrition rate, active employees |
| Department Analysis | Department-wise employee turnover |
| Gender Analysis | Attrition distribution by gender |
| Age Analysis | Employee attrition by age groups |
| Job Role Analysis | Attrition across different job roles |
| Salary Analysis | Income and compensation analysis |
| Experience Analysis | Attrition based on years of experience |
| Job Satisfaction | Employee satisfaction and retention patterns |

### Important KPIs

- Total Employees
- Attrition Count
- Active Employees
- Attrition Rate
- Average Employee Age
- Average Monthly Income
- Average Years at Company

**Attrition Rate Formula:**

```text
Attrition Rate (%) =
(Employees Who Left / Total Employees) × 100
```

## 🗄️ 7. Data Model

The application uses employee-related data to support workforce analysis.

### Main Entities

**1. Employees**

| Field | Description |
|---|---|
| EmployeeID | Unique employee identifier |
| Age | Employee age |
| Gender | Employee gender |
| DepartmentID | Department reference |
| JobRole | Employee job role |
| MonthlyIncome | Monthly salary |
| YearsAtCompany | Company experience |
| JobSatisfaction | Satisfaction rating |

**2. Departments**

| Field | Description |
|---|---|
| DepartmentID | Unique department ID |
| DepartmentName | Department name |

**3. Attrition Events**

| Field | Description |
|---|---|
| EventID | Unique event ID |
| EmployeeID | Employee reference |
| ExitDate | Employee exit date |
| ExitReason | Reason for leaving |

*The attrition events table is an optional extension for historical tracking. A basic HR dataset may instead use an Attrition Yes/No field in the Employees table.*

## 🏗️ 8. Application Architecture

```text
          HR / Management Users
                   |
                   v
            React Frontend
                   |
                   v
           Express REST API
                   |
                   v
          Node.js Backend
                   |
                   v
            PostgreSQL
                   |
                   v
         Employee Analytics
                   |
                   v
          Interactive Charts
```

### Architecture Components

- **Frontend:** Displays interactive dashboards and visualizations.
- **Backend:** Handles business logic and API requests.
- **Database:** Stores employee and attrition information.
- **Analytics Layer:** Calculates KPIs and generates analytical insights.
- **Authentication:** Provides secure access when enabled.

## 🔌 9. API Endpoints

Example REST API design:

| Method | Endpoint | Purpose |
|---|---|---|
| GET | `/api/employees` | Retrieve employees |
| GET | `/api/employees/:id` | Retrieve employee details |
| GET | `/api/analytics/overview` | Dashboard KPIs |
| GET | `/api/analytics/attrition` | Attrition statistics |
| GET | `/api/analytics/departments` | Department analysis |
| GET | `/api/analytics/demographics` | Demographic analysis |
| GET | `/api/analytics/satisfaction` | Satisfaction analysis |

## 🔐 10. Configuration

Example environment configuration:

```env
# Server
PORT=5000
NODE_ENV=development

# Database
DATABASE_URL=postgresql://postgres:password@localhost:5432/employee_attrition

# Authentication
JWT_SECRET=replace_with_a_secure_random_secret

# Frontend
CLIENT_URL=http://localhost:5173
```

Never commit actual passwords, API keys, or production credentials to GitHub.

## 🧪 11. Testing

Run frontend tests:

```bash
cd frontend
npm test
```

Run backend tests:

```bash
cd backend
npm test
```

### Testing Guidelines

- Validate API responses.
- Test database connections.
- Verify KPI calculations.
- Test dashboard filters.
- Validate CSV exports.
- Check responsive layouts.
- Test authentication and authorization if implemented.

*These commands require the corresponding test scripts to be configured in package.json.*

## 🚀 12. Deployment

Suggested deployment architecture:

| Component | Hosting |
|---|---|
| React Frontend | Vercel |
| Node.js Backend | Render |
| PostgreSQL Database | Supabase / Managed PostgreSQL |
| Source Code | GitHub |

### Deployment Workflow

1. Push source code to GitHub.
2. Connect the frontend repository to Vercel.
3. Deploy the backend to Render.
4. Configure production database credentials.
5. Set environment variables.
6. Test deployed API endpoints.
7. Verify the live dashboard.

### CI/CD

An optional GitHub Actions workflow can automate:

- Dependency installation.
- Code linting.
- Unit testing.
- Production builds.
- Deployment after successful checks.

## 🤝 13. Contribution Guidelines

Contributions are welcome!

1. Fork the repository.
2. Create a feature branch.
3. Implement your changes.
4. Test your code.
5. Commit your changes.
6. Submit a pull request.

Example:

```bash
git checkout -b feature/dashboard-improvements

git add .

git commit -m "Add department attrition analysis"

git push origin feature/dashboard-improvements
```

Please follow consistent coding standards, document new features, and respect the project's code of conduct.

## 📜 14. License

This project is available under the MIT License.

You may use, modify, and distribute the project according to the license terms.

See the `LICENSE` file for details.

## 👨‍💻 15. Author

**Idrish Khan**

MCA Graduate | Aspiring Data Analyst

Areas of Interest:
- Data Analytics
- Business Intelligence
- SQL & Python
- Power BI
- Data Visualization

GitHub: https://github.com/yourusername

LinkedIn: https://www.linkedin.com/in/yourusername/

## 📚 16. References

- React: https://react.dev/
- Node.js: https://nodejs.org/
- Express.js: https://expressjs.com/
- PostgreSQL: https://www.postgresql.org/docs/
- Tailwind CSS: https://tailwindcss.com/
- Recharts: https://recharts.org/
- Vite: https://vite.dev/
- GitHub Actions: https://docs.github.com/en/actions

## ⚡ 17. Quick Start Example

Once the application and database are configured:

```bash
# Clone project
git clone https://github.com/yourusername/employee-attrition-dashboard.git

# Enter project
cd employee-attrition-dashboard

# Install frontend dependencies
cd frontend && npm install

# Install backend dependencies
cd ../backend && npm install

# Start backend (from backend directory)
npm run dev

# Start frontend in a separate terminal
cd frontend
npm run dev
```

Visit `http://localhost:5173` to explore the dashboard.

---

## ⭐ Support

If you find this project useful, consider giving the repository a ⭐ on GitHub.

**Turning employee data into actionable workforce insights.**
