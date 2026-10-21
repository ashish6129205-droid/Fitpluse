# FitPulse — Online Fitness Tracking Application

FitPulse is a full-stack fitness tracking web application built with pure Jakarta EE
(Servlets + JSP + JSTL), plain JDBC, and PostgreSQL. It demonstrates modern fitness SaaS aesthetic, multi-tier architecture, async background task threading, and robust OOP practices.

## Tech Stack
- **Java 17**, Maven
- **Jakarta Servlet 6.0**, JSP 3.1, JSTL 3.0 (jakarta.tags.core)
- **Database:** Plain JDBC with PreparedStatement (DAO pattern), PostgreSQL (Neon cloud)
- **Deployment:** Apache Tomcat 10.1 (packaged as ROOT.war), Docker multi-stage build
- **Security:** BCrypt password hashing (jBCrypt), Try-with-resources resource handling
- **Frontend:** Pure CSS Dark Glassmorphism Theme, Chart.js for data visualization

## Features
- **User Portal:** Dashboard with dynamic Chart.js analytics, workout logging, progression tracking, goal tracking, and community challenges.
- **Admin Portal:** Content moderation, user management, and multithreaded live background activity logging.
- **Innovation:** Stream API-powered Analytics engine, dynamic Leaderboards, streak calculators, and **CSV Export** for personal workout histories.

## Environment Variables
| Variable      | Description                                             |
|---------------|---------------------------------------------------------|
| `DATABASE_URL`| e.g. `postgres://USER:PASS@HOST/DB?sslmode=require`     |
| `PORT`        | Server port (default 8080)                              |

*Note: The application automatically handles JDBC formatting from the generic connection string and initializes schemas & seeded admin accounts on startup natively.*

## Local Build & Run
```bash
mvn clean package -DskipTests
# Deploy target/ROOT.war to Tomcat 10.1 webapps/
```

## Testing & Verification
The application includes a JUnit 5 automated test suite bound to the Maven lifecycle.
To execute tests and verify integrity:
```bash
mvn clean test
```

### Unit Tests Implemented
| Test Class | Coverage |
|------------|----------|
| `ValidationUtilTest` | Email formatting logic, password strength requirements, workout input boundary conditions. |
| `PasswordHashTest` | jBCrypt hashing operations, verification logic, prefix handling ($2a, $2b, $2y), and empty/null safeguards. |
| `AnalyticsTest` | Data collection scaling, total calories aggregation, completed challenges logic for UserRank model. |

## System Overview
- **Multithreading:** Features a ThreadPoolExecutor managing an `ActivityLogService` for async database logging to prevent HTTP thread blocking.
- **Transaction Handling:** Complex DAO actions (like `joinChallenge`) strictly handle transactions manually (`setAutoCommit(false)`, `commit`, `rollback`) wrapped with a custom `DaoException`.
