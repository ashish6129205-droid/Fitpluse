# FitPulse — Online Fitness Tracking Application

FitPulse is a full-stack fitness tracking web application built with pure Jakarta EE
(Servlets + JSP + JSTL), plain JDBC, and PostgreSQL. Users can log workouts, track
progress, manage goals, join challenges, log nutrition/water, and earn achievements.
Admins can manage users, challenges, content approvals, and system settings.

## Tech Stack

- Java 17, Maven
- Jakarta Servlet 6.0, JSP 3.1, JSTL 3.0 (jakarta.tags.core)
- Plain JDBC with PreparedStatement (DAO pattern)
- PostgreSQL (Neon cloud database)
- BCrypt password hashing (jBCrypt)
- Apache Tomcat 10.1 (packaged as ROOT.war)
- Chart.js (CDN) for progress charts
- Docker multi-stage build

## Project Layout

- `com.fitpulse.model` — POJOs
- `com.fitpulse.dao` / `com.fitpulse.dao.impl` — DAO interfaces & JDBC implementations
- `com.fitpulse.service` — business logic
- `com.fitpulse.servlet` — controllers (`@WebServlet`)
- `com.fitpulse.filter` — role-based auth filter
- `com.fitpulse.listener` — startup listener (auto-creates tables + default admin)
- `com.fitpulse.util` — DB connection & password utilities
- `src/main/webapp` — JSPs, CSS, JS

## Environment Variables

| Variable      | Description                                             |
|---------------|---------------------------------------------------------|
| `DB_URL`      | e.g. `jdbc:postgresql://HOST/DB?sslmode=require`        |
| `DB_USER`     | Database username                                       |
| `DB_PASSWORD` | Database password                                       |
| `PORT`        | Server port (default 8080)                              |

Credentials are NEVER hardcoded. On startup the app runs `CREATE TABLE IF NOT EXISTS`
for all tables and seeds a default admin if no admin exists:

- Email: `admin@fitpulse.com`
- Password: `Admin@123`

## Local Build

```bash
mvn clean package
# deploy target/ROOT.war to Tomcat 10.1 webapps/
