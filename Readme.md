# FitPulse — Intelligent Fitness Tracking Web Application

FitPulse is a modern, responsive, full-stack Java web application built with Jakarta EE (Servlets + JSP + JSTL), plain JDBC, and PostgreSQL. Users can log workouts, track fitness metrics, join community challenges, view dynamic leaderboards, and log activity. Administrators have dedicated tools to manage users, moderate community content, and review real-time multithreaded system activity logs.

---

## 🚀 Live Application & Demo
- **Live URL:** [https://fitpluse.onrender.com](https://fitpluse.onrender.com)
- **Demo User:** `user@fittrack.demo` | **Password:** `User@123`
- **Demo Admin:** `admin@fitpulse.com` | **Password:** `Admin@123`

---

## 🛠️ Tech Stack & Architecture

- **Architecture:** Model-View-Controller (MVC) Pattern
- **Language & Runtime:** Java 17, Apache Tomcat 10.1 (Docker multi-stage build)
- **Web Technologies:** Jakarta Servlet 6.0, JSP 3.1, JSTL 3.0 (`jakarta.tags.core`)
- **Database:** PostgreSQL (Neon Cloud Database) with Connection Lifecycle Optimization
- **Data Access:** Plain JDBC with `PreparedStatement` (DAO Pattern)
- **Security:** BCrypt salted password hashing, Role-Based Session Filters
- **UI/UX:** Dark Glassmorphism, Responsive Mobile-First CSS Grid/Flexbox
- **Build Tool:** Apache Maven

---

## 📋 Academic Rubric Alignment (Review 1)

### 1. Core Java Concepts & OOP (10 Marks)
- **Encapsulation:** JavaBean domain models (`User`, `Workout`, `Challenge`, `FitnessContent`) with strictly private fields and validated getters/setters.
- **Abstraction & Interfaces:** Clean Data Access Object (DAO) architecture (`WorkoutDao`, `ChallengeDao`, `ActivityLogDao`, `UserDao`) decoupled from SQL implementations.
- **Polymorphism:** Dynamic method dispatch via interface bindings across Servlet controller layers.
- **Collections & Stream API:** `LeaderboardService` leverages Java Stream API (`.stream()`, `.filter()`, `.sorted()`, `Collectors.groupingBy()`) to compute user rankings, active workout streaks, and exercise volume aggregations in-memory.
- **Multithreading & Concurrency:** `ActivityLogService` implements an asynchronous `ExecutorService` thread pool to write system audit logs without blocking client HTTP request threads.

### 2. Database Integration — JDBC (8 Marks)
- **Relational Schema:** 8 normalized tables with foreign key constraints, default timestamps, and referential integrity (`ON DELETE CASCADE`).
- **ACID Transaction Management:** Manual transaction demarcation (`setAutoCommit(false)`, `commit()`, `rollback()`) implemented for atomic multi-table operations (e.g., joining challenges and counter increments).
- **SQL Injection Prevention:** 100% parameter binding through `PreparedStatement`.

### 3. Servlets & Web Integration (7 Marks)
- **Controllers & Routing:** Structured controllers (`WorkoutServlet`, `ChallengeServlet`, `LeaderboardServlet`, `AdminServlet`, `AuthServlet`) handling client interactions and forwarding to dynamic JSP views.
- **Session Management:** Secure HTTP session handling with active user authentication state and role segregation (`USER` vs `ADMIN`).
- **Global Error Handling:** Application-level error interceptors configured in `web.xml` routing to custom glassmorphic `404` and `500` error pages.

### 4. Problem Understanding & Solution Design (8 Marks)
- High-contrast, mobile-responsive dark glassmorphic dashboard delivering real-time metrics, workout logs, atomic challenge enrollment, and admin moderation workflows.

---

## 📂 Project Structure

- `com.fitpulse.model` — JavaBean domain models / POJOs (Encapsulation)
- `com.fitpulse.dao` / `com.fitpulse.dao.impl` — DAO interfaces & JDBC implementations (Abstraction & Polymorphism)
- `com.fitpulse.service` — Business logic, Stream API aggregations, and Multithreaded ExecutorService
- `com.fitpulse.servlet` — Web controllers handling GET/POST requests (`@WebServlet`)
- `com.fitpulse.filter` — Role-based authentication and route protection
- `com.fitpulse.listener` — Application lifecycle listener
- `com.fitpulse.util` — DB connection management & BCrypt utilities
- `src/main/webapp` — Responsive JSPs, dark theme CSS, and client assets

---

## ⚙️ Environment Variables

| Variable      | Description                                             |
|---------------|---------------------------------------------------------|
| `DB_URL`      | e.g. `jdbc:postgresql://HOST/DB?sslmode=require`        |
| `DB_USER`     | Database username                                       |
| `DB_PASSWORD` | Database password                                       |
| `PORT`        | Server port (default 8080)                              |

---

## 💻 Local Build & Run

```bash
# Clone the repository
git clone [https://github.com/ashish6129205-droid/Fitpluse.git](https://github.com/ashish6129205-droid/Fitpluse.git)
cd Fitpluse

# Build and package WAR
mvn clean package -DskipTests

# Deploy target/ROOT.war to Tomcat 10.1 webapps/
