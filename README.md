# 🧊 Cold-Chain Logistics AI Assistant

> An enterprise-grade AI-powered dispatch console that transforms real-time supply chain data into actionable insights for logistics operations.

[![Python](https://img.shields.io/badge/Python-3.12-blue.svg)](https://www.python.org/)
[![Streamlit](https://img.shields.io/badge/Streamlit-1.62-red.svg)](https://streamlit.io/)
[![LangGraph](https://img.shields.io/badge/LangGraph-1.2-green.svg)](https://langchain.com/)
[![SQL Server](https://img.shields.io/badge/SQL_Server-2022-orange.svg)](https://www.microsoft.com/en-us/sql-server/)

---

## 📋 Table of Contents
- [Overview](#-overview)
- [Key Features](#-key-features)
- [Architecture](#-architecture)
- [Tech Stack](#-tech-stack)
- [Demo & Screenshots](#-demo--screenshots)
- [Getting Started](#-getting-started)
- [Project Structure](#-project-structure)
- [Security & Compliance](#-security--compliance)
- [Future Enhancements](#-future-enhancements)

---

## 🎯 Overview

This project addresses a critical challenge in modern supply chain management: **real-time decision-making for cold-chain logistics**. When temperature-sensitive cargo experiences anomalies during transit, every minute counts. Traditional systems require manual data correlation across multiple sources—this AI assistant does it automatically.

**The Problem:**
- Dispatchers juggle between legacy SQL databases, weather APIs, and compliance documents
- Critical temperature breaches can lead to thousands of dollars in spoiled cargo
- Route diversions require instant access to SOPs buried in PDF files

**The Solution:**
An intelligent agent that converses naturally with logistics teams, automatically querying telemetry databases, checking live weather conditions, and retrieving relevant compliance procedures—all in one unified interface.

---

## ✨ Key Features

### 🤖 **Intelligent Multi-Tool Orchestration**
- **LangGraph-powered reasoning engine** that autonomously selects and chains tools
- Supports DeepSeek R1, OpenAI GPT-4o, and local Ollama models
- Maintains conversation context across complex multi-turn queries

### 📊 **Real-Time Data Integration**
- **SQL database queries** against Microsoft SQL Server with role-based access control
- **Live weather API integration** (Open-Meteo) for corridor condition analysis
- **Vector similarity search** using Pinecone for instant SOP retrieval

### 🔐 **Enterprise-Grade Security**
- Row-level security with dedicated read-only agent user (`USR_FDE_RO`)
- Audit logging for every agent action and tool invocation
- Separation of concerns: agents can't access raw legacy tables

### 🎨 **Production-Ready UI**
- Built with **Streamlit** for rapid prototyping and deployment
- Real-time streaming of agent reasoning process
- Dual-mode interface: Dispatch Console + Security Audit Viewer

### 📈 **Data Engineering Pipeline**
- Automated ingestion from CSV to SQL Server with legacy schema mapping
- Incremental SOP processing with MD5-based change detection
- Support for Markdown, PDF, CSV, and Excel document parsing

---

## 🏗️ Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                     STREAMLIT UI LAYER                      │
│  • Multi-session management  • Real-time streaming         │
│  • Audit log visualization   • Enterprise theming          │
└────────────────────┬────────────────────────────────────────┘
                     │
┌────────────────────▼────────────────────────────────────────┐
│                  LANGGRAPH ORCHESTRATOR                     │
│                                                             │
│  ┌─────────────┐      ┌──────────────┐                    │
│  │  Reasoner   │◄────►│  Tool Node   │                    │
│  │   (LLM)     │      │  (Executor)  │                    │
│  └─────────────┘      └──────────────┘                    │
│         │                      │                           │
│         │                      ▼                           │
│         │         ┌────────────────────────┐              │
│         │         │  Agent Tools Layer     │              │
│         │         └────────────────────────┘              │
└─────────┼──────────────────┬─────────────────────────────┘
          │                  │
          ▼                  ▼
┌──────────────────┐  ┌─────────────────────────────────────┐
│   Pinecone       │  │  External Data Sources              │
│   Vector Store   │  │                                     │
│                  │  │  • SQL Server (Fleet Telemetry)    │
│  • SOP Documents │  │  • Weather API (Corridor Risks)    │
│  • Compliance    │  │  • Audit Log Table                 │
│    Procedures    │  │                                     │
└──────────────────┘  └─────────────────────────────────────┘
```

### Agent Tool System

| Tool Name | Purpose | Data Source |
|-----------|---------|-------------|
| `query_telemetry_db` | Executes SQL queries on fleet GPS, temperature, and risk metrics | SQL Server View |
| `fetch_corridor_conditions` | Retrieves live weather and congestion index for coordinates | Open-Meteo API |
| `search_compliance_sop` | Semantic search across standard operating procedures | Pinecone Vector DB |

---

## 🛠️ Tech Stack

### **Core Frameworks**
- **LangGraph** - Agent workflow orchestration with state management
- **LangChain** - LLM abstraction and tool integration
- **Streamlit** - Interactive web application framework

### **AI & ML**
- **DeepSeek R1** / **OpenAI GPT-4o** - Primary reasoning models
- **OpenAI Embeddings** / **HuggingFace BGE-M3** - Vector embedding generation
- **Pinecone** - Serverless vector database for semantic search

### **Data Infrastructure**
- **Microsoft SQL Server 2022** - Production database (Docker)
- **SQLAlchemy** - Python SQL toolkit and ORM
- **PyODBC** - ODBC database connectivity
- **Pandas** - Data manipulation and CSV processing

### **Additional Technologies**
- **PyPDF** - PDF document parsing
- **python-dotenv** - Environment configuration management
- **scikit-learn** - Machine learning utilities

---

## 🖼️ Demo & Screenshots

### Dispatch Console Interface
The main interface where logistics teams interact with the AI assistant. The agent automatically:
1. Queries the SQL database for nearby shipments
2. Checks live weather conditions at the location
3. Retrieves relevant SOP procedures
4. Synthesizes a actionable report with temperature breach protocols

**Sample Query:**
```
"Find any active shipments near Los Angeles (Lat ~33.8, Lon ~-118.1). 
Check the local weather there, and tell me if the current cargo 
temperature violates the SOP for fresh perishables."
```

**Agent Response Structure:**
```markdown
### 1. Executive Summary
* 3 active shipments detected within 50km radius
* 2 vehicles showing temperature readings above SOP threshold

### 2. Telemetry & Environment Analysis
| Location | Current Temp | Cargo Risk | Weather |
|----------|-------------|------------|---------|
| 33.77, -118.19 | 5.2°C | High | 14°C, Wind 22 km/h |

*Analysis:* External temperatures are within normal range, but 
internal cargo sensors indicate cooling system malfunction.

### 3. Required Action Plan
1. **Immediate Driver Contact**: Restart auxiliary cooling unit
2. **Divert if ETA > 1 hour**: Route to nearest cold-storage facility

*SOP Compliance Citation:* Cold_Chain_Incident_SOP_v2.md, Section 1.3
```

### Security Audit Dashboard
Administrators can review every agent interaction with full transparency:
- Session tracking by unique thread ID
- Tool invocation logs with complete input/output payloads
- Timestamp-based filtering for compliance audits

---

## 🚀 Getting Started

### Prerequisites
- Python 3.12+
- Docker (for SQL Server)
- Microsoft ODBC Driver 18 for SQL Server
- API Keys: Pinecone, OpenAI/DeepSeek (optional)

### 1. Clone Repository
```bash
git clone https://github.com/yourusername/cold-chain-logistics-FDE-Project.git
cd cold-chain-logistics-FDE-Project
```

### 2. Environment Setup
```bash
# Create virtual environment
python -m venv venv

# Activate (Windows)
venv\Scripts\activate

# Activate (Unix/MacOS)
source venv/bin/activate

# Install dependencies
pip install -r requirements.txt
```

### 3. Configure Environment Variables
Create a `.env` file in the project root:

```env
# SQL Server Configuration
SQL_SERVER_HOST=localhost
SQL_SERVER_PORT=1433
SQL_ADMIN_USER=sa
SQL_ADMIN_PASSWORD=FdeEnterprisePass123!
SQL_AGENT_USER=USR_FDE_RO
SQL_AGENT_PASSWORD=AgentPassword2026!

# AI Model Configuration
Agent_llm=DEEPSEEK                      # Options: DEEPSEEK, OPENAI, OLLAMA
Embeddings_model=LOCAL                   # Options: LOCAL, OPENAI
Local_Embedding_Model=BAAI/bge-m3

# API Keys
PINECONE_API_KEY=your_pinecone_api_key
DEEPSEEK_API_KEY=your_deepseek_api_key  # If using DeepSeek
OPENAI_API_KEY=your_openai_api_key      # If using OpenAI
```

### 4. Launch SQL Server (Docker)
```bash
docker run -e "ACCEPT_EULA=Y" ^
  -e "MSSQL_SA_PASSWORD=FdeEnterprisePass123!" ^
  -p 1433:1433 --name legacy-mssql ^
  -d mcr.microsoft.com/mssql/server:2022-latest
```

### 5. Ingest Legacy Data
```bash
python scripts\ingest_legacy_data.py
```

### 6. Setup Security & Views
Execute `scripts\setup_security_and_view.sql` using Azure Data Studio or VS Code SQL extension.

### 7. Ingest SOP Documents
```bash
python scripts\ingest_sop_pinecone.py
```

### 8. Launch Application
```bash
streamlit run src\ui.py
```

Access the application at `http://localhost:8501`

---

## 📁 Project Structure

```
cold-chain-logistics-FDE-Project/
│
├── data/
│   ├── cache/                    # MD5 hash cache for incremental ingestion
│   ├── policy/                   # SOP documents (Markdown, PDF)
│   ├── raw/                      # CSV datasets
│   └── source/                   # Original data sources
│
├── scripts/
│   ├── ingest_legacy_data.py     # CSV → SQL Server pipeline
│   ├── ingest_sop_pinecone.py    # Document → Pinecone vectorization
│   └── setup_security_and_view.sql # RBAC and view creation
│
├── src/
│   ├── prompts/
│   │   └── system_prompt.txt     # Business-focused agent instructions
│   ├── agent_tools.py            # Tool definitions (SQL, API, Vector DB)
│   ├── orchestrator.py           # LangGraph state machine
│   └── ui.py                     # Streamlit application
│
├── .streamlit/
│   └── config.toml               # UI theme configuration
│
├── docs/
│   └── instructions.md           # Detailed deployment guide
│
├── requirements.txt              # Python dependencies
├── .env.example                  # Environment template
└── README.md                     # This file
```

---

## 🔐 Security & Compliance

### Role-Based Access Control (RBAC)
- **Admin User (`sa`)**: Full database access, schema modifications
- **Agent User (`USR_FDE_RO`)**: Read-only access to cleaned views, write access to audit table
- **Legacy Tables**: Direct access blocked for agent to prevent data exposure

### Audit Trail
Every agent interaction is logged to `FDE_VIEWS.AgentAuditLog`:
- Session ID tracking
- Tool invocation timestamps
- Complete input/output payloads
- Node execution paths

### Data Privacy
- No raw legacy table access for AI agents
- SQL injection protection via parameterized queries
- Environment-based credential management (no hardcoded secrets)

---

## 🎓 What I Learned

Building this project taught me:

1. **Production AI Architecture**: How to design agent systems that are observeable, debuggable, and secure
2. **Data Engineering at Scale**: Incremental processing pipelines with change detection and batch optimization
3. **Enterprise Integration**: Working with legacy SQL schemas, ODBC drivers, and role-based security
4. **LangGraph Workflows**: State machines for complex multi-tool orchestration with conditional routing
5. **Vector Embeddings in Production**: Trade-offs between cloud (OpenAI) and local (HuggingFace) embedding models

---

## 🔮 Future Enhancements

- [ ] **Real-time WebSocket Integration**: Live telemetry streaming from IoT sensors
- [ ] **Multi-Tenancy Support**: Customer-specific data isolation and branding
- [ ] **Advanced Analytics**: Predictive models for delay probability and spoilage risk
- [ ] **Mobile Companion App**: Driver interface for incident reporting
- [ ] **Kubernetes Deployment**: Container orchestration for horizontal scaling
- [ ] **GraphQL API Layer**: Expose agent capabilities to third-party systems

---

## 📝 License

This project is built as a portfolio demonstration. Feel free to reference the architecture and implementation patterns for educational purposes.

---

## 🤝 Contact

**Project Author**: [Your Name]  
**Email**: your.email@example.com  
**LinkedIn**: [linkedin.com/in/yourprofile](https://linkedin.com/in/yourprofile)  
**Portfolio**: [yourportfolio.com](https://yourportfolio.com)

---

## 🙏 Acknowledgments

- **DeepSeek** for providing cutting-edge reasoning models
- **LangChain Team** for the incredible agent framework ecosystem
- **Open-Meteo** for free weather API access
- **Pinecone** for serverless vector database infrastructure

---

<div align="center">

**Built with ❤️ and ☕ for the future of autonomous logistics**

[⭐ Star this repo](https://github.com/yourusername/cold-chain-logistics-FDE-Project) if you find it useful!

</div>

# Final: recruiter-friendly updates
