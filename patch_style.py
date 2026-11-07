with open('src/main/webapp/css/style.css', 'r') as f:
    content = f.read()

content = content.replace('--bg-obsidian: #0a0f1d;', '--bg-obsidian: #0b0f19;')
content = content.replace('--card-slate: #151e32;', '--card-slate: #111827;\n    --card-slate-secondary: #1e293b;')
content = content.replace('--text-primary: #f8fafc;', '--text-primary: #ffffff;')
content = content.replace('--text-secondary: #94a3b8;', '--text-secondary: #cbd5e1;')

card_search = """.card {
    background-color: var(--card-slate);
    border: 1px solid var(--border-subtle);
    border-radius: 1rem;
    box-shadow: var(--shadow-soft);
    color: var(--text-primary);
    margin-bottom: 1.5rem;
    overflow: hidden;
}"""
card_replace = """.card {
    background-color: var(--card-slate);
    border: 1px solid rgba(255, 255, 255, 0.08);
    border-radius: 14px;
    box-shadow: var(--shadow-soft);
    color: var(--text-primary);
    margin-bottom: 1.5rem;
    overflow: hidden;
}"""
content = content.replace(card_search, card_replace)

headings_search = """h1, h2, h3, h4, h5, h6 {
    color: var(--text-primary);
    font-weight: 600;
    letter-spacing: -0.02em;
}"""
headings_replace = """h1, h2, h3, h4, h5, h6 {
    color: #ffffff;
    font-weight: 600;
    letter-spacing: -0.02em;
}"""
content = content.replace(headings_search, headings_replace)


badges_search = """.badge {
    padding: 0.4em 0.8em;
    border-radius: 6px;
    font-weight: 600;
    font-size: 0.75rem;
    letter-spacing: 0.02em;
}
.bg-primary {
    background-color: rgba(6, 182, 212, 0.1) !important;
    color: var(--accent-cyan) !important;
    border: 1px solid rgba(6, 182, 212, 0.2);
}
.bg-success {
    background-color: rgba(16, 185, 129, 0.1) !important;
    color: var(--accent-emerald) !important;
    border: 1px solid rgba(16, 185, 129, 0.2);
}"""

badges_replace = """.badge {
    padding: 0.4em 0.8em;
    border-radius: 6px;
    font-weight: 600;
    font-size: 0.75rem;
    letter-spacing: 0.02em;
    color: #ffffff !important;
}
.badge-type {
    color: #ffffff !important;
}
.bg-primary {
    background-color: #2563eb !important;
    color: #ffffff !important;
    border: 1px solid #2563eb;
}
.bg-success {
    background-color: #10b981 !important;
    color: #ffffff !important;
    border: 1px solid #10b981;
}"""
content = content.replace(badges_search, badges_replace)

stat_search = """.stat-card.emerald h3 { color: var(--accent-emerald); }
.stat-card.cyan h3 { color: var(--accent-cyan); }
.stat-card.amber h3 { color: var(--accent-amber); }
.stat-card.primary h3 { color: var(--text-primary); }"""

stat_replace = """.stat-card.emerald { border-top: 4px solid var(--accent-emerald); }
.stat-card.emerald h3 { color: var(--accent-emerald); }
.stat-card.cyan { border-top: 4px solid var(--accent-cyan); }
.stat-card.cyan h3 { color: var(--accent-cyan); }
.stat-card.amber { border-top: 4px solid var(--accent-amber); }
.stat-card.amber h3 { color: var(--accent-amber); }
.stat-card.primary { border-top: 4px solid var(--accent-cyan); }
.stat-card.primary h3 { color: var(--text-primary); }"""
content = content.replace(stat_search, stat_replace)

with open('src/main/webapp/css/style.css', 'w') as f:
    f.write(content)
