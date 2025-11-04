# Claude Code Configuration - CRM Project Workspace

## 📋 Overview

This workspace is a **multi-project development environment** managed with **Speckit** (project management tool) and configured for **Claude Code** integration. It contains multiple active projects across different technology stacks.

## 🏗️ Workspace Structure

```
/home/zhaslan/code/
├── CRM/                    # 🎯 CRM Project (Speckit-managed)
│   ├── .claude/           # Claude Code configuration
│   │   ├── settings.json  # Claude settings (MiniMax-M2 model)
│   │   ├── settings.local.json
│   │   └── commands/      # Speckit slash commands
│   └── claude.md         # This file
│
├── HR AI/                  # 🤖 HR AI Assistant Project
│   └── HR-AI/             # Python + AI/ML stack
│       ├── specs/         # Speckit specifications
│       ├── memory/        # Project memory & constitution
│       ├── knowledge_base/# Domain knowledge
│       └── .venv/         # Python virtual environment
│
├── smart-document/         # 📄 Smart Document System
│   ├── Backend/           # Backend services
│   ├── src/               # Source code
│   ├── DB.sql             # Database schema
│   ├── ERD.pgerd          # Entity Relationship Diagram
│   └── package.json       # Node.js dependencies
│
├── Flutter/                # 📱 Flutter Applications
│   └── chatgpt_clone/     # ChatGPT Flutter clone
│
├── arr/                   # 🧮 Java Algorithms
│   └── RandomArray.java
│
└── konkurs/               # 📝 Contest/Konkurs Files
```

## 🚀 Technology Stack Summary

### CRM Project
- **Status**: Project setup phase (Speckit-managed)
- **Framework**: TBD (see specs/)
- **Language**: TBD
- **Database**: TBD

### HR AI Project
- **Language**: Python
- **AI/ML**: Sentence Transformers, SPLADE
- **Framework**: FastAPI/Flask (inferred from structure)
- **Specialization**: HR policy assistant with knowledge base
- **Documentation**: Comprehensive Speckit specs

### Smart Document System
- **Language**: JavaScript/TypeScript
- **Runtime**: Node.js
- **Database**: PostgreSQL (with ERD)
- **Architecture**: Full-stack with Backend/
- **Package Manager**: npm

### Flutter Applications
- **Language**: Dart
- **Framework**: Flutter
- **Projects**: ChatGPT clone, mobile apps
- **Platform**: Cross-platform (Android, iOS, Web)

### Java Algorithms
- **Language**: Java
- **Focus**: Algorithm implementations
- **Files**: RandomArray, data structures

## 🛠️ Development Environment

### Claude Code Configuration
- **Model**: MiniMax-M2 (via Anthropic-compatible API)
- **Base URL**: https://api.minimax.io/anthropic
- **Timeout**: 3,000,000ms (50 minutes)
- **Features**: Speckit integration enabled

### Installed Tools
- **Node.js**: Package management with npm
- **Python 3.12**: With virtual environments (.venv)
- **Flutter**: Mobile app development
- **Java**: Algorithm development
- **PostgreSQL**: Database (smart-document project)
- **Git**: Version control (used in smart-document)

## 📚 Speckit Workflow Commands

The workspace includes custom slash commands for Speckit project management:

### Core Commands
- `/speckit.specify` - Create feature specifications
- `/speckit.plan` - Generate implementation plans
- `/speckit.tasks` - Create actionable task lists
- `/speckit.implement` - Execute implementation workflow
- `/speckit.analyze` - Analyze spec/plan/task consistency
- `/speckit.clarify` - Identify underspecified areas
- `/speckit.checklist` - Generate custom checklists
- `/speckit.constitution` - Manage project constitution

### Workflow Pattern
1. **Specify**: Define what to build (spec.md)
2. **Plan**: Design how to build it (plan.md)
3. **Tasks**: Break down into steps (tasks.md)
4. **Analyze**: Validate completeness
5. **Implement**: Execute tasks
6. **Checklist**: Track completion

## 🎯 Current Projects Status

### 1. HR AI (Active - Advanced Stage)
**Location**: `/home/zhaslan/code/HR AI/HR-AI/`

**Specifications Available**:
- Feature specs (001-hr-ai-tool/)
- Implementation plan
- Task breakdown
- Knowledge base (hr_policy.md)
- Constitution defined

**Tech Stack**:
- Python 3.12
- Sentence Transformers (AI/ML)
- SPLADE (sparse encoder)
- FastAPI likely
- Virtual environment configured

**Next Steps**:
- Review existing specs in `specs/001-hr-ai-tool/`
- Run `/speckit.implement` to continue development
- Check task completion in tasks.md

### 2. Smart Document (Active - Development)
**Location**: `/home/zhaslan/code/smart-document/`

**Features**:
- Full-stack Node.js application
- PostgreSQL database
- ERD provided
- Active Git repository

**Next Steps**:
- Review README.md for project details
- Check Backend/ directory for API structure
- Review DB.sql for database schema

### 3. Flutter Projects (Active)
**Location**: `/home/zhaslan/code/Flutter/`

**Projects**:
- ChatGPT clone

**Next Steps**:
- Explore chatgpt_clone/ directory
- Check .cursor/ for IDE configuration

### 4. CRM Project (Planning Phase)
**Location**: `/home/zhaslan/code/CRM/`

**Status**: Setup complete, awaiting feature specification

**Next Steps**:
1. Define CRM requirements
2. Run `/speckit.specify` to create spec.md
3. Choose tech stack (recommend reviewing other projects for patterns)
4. Continue through Speckit workflow

## 💡 Best Practices

### Code Organization
- Each project is self-contained
- Speckit projects use `/specs/` directory for documentation
- Virtual environments for Python projects
- package.json for Node.js dependencies

### Development Workflow
1. **Always use Speckit for new features**
2. **Document decisions in constitution.md**
3. **Keep specifications in /specs/ directory**
4. **Review constitution before major changes**
5. **Use /speckit.analyze before implementation**

### Claude Code Integration
- Claude is configured with MiniMax-M2 model
- Use slash commands (/speckit.*) for project management
- All Speckit commands available from workspace root
- Claude remembers context across commands

## 🔧 Common Commands

### Workspace Navigation
```bash
# View all projects
ls -la /home/zhaslan/code/

# Check specific project
ls -la /home/zhaslan/code/HR\ AI/HR-AI/
cd /home/zhaslan/code/HR\ AI/HR-AI/

# Run Speckit commands from project root
cd /home/zhaslan/code/HR\ AI/HR-AI/
/speckit.tasks
```

### Project-Specific

**HR AI**:
```bash
cd /home/zhaslan/code/HR\ AI/HR-AI/
source .venv/bin/activate  # Activate Python env
python --version
```

**Smart Document**:
```bash
cd /home/zhaslan/code/smart-document/
npm install
npm start  # Check package.json for exact command
```

**Flutter**:
```bash
cd /home/zhaslan/code/Flutter/chatgpt_clone/
flutter --version
flutter run  # Check for available devices
```

## 📖 Documentation Locations

- **HR AI Specs**: `/home/zhaslan/code/HR AI/HR-AI/specs/001-hr-ai-tool/`
- **Smart Document README**: `/home/zhaslan/code/smart-document/README.md`
- **Database Schema**: `/home/zhaslan/code/smart-document/DB.sql`
- **ERD**: `/home/zhaslan/code/smart-document/ERD.pgerd`
- **HR Policy Knowledge**: `/home/zhaslan/code/HR AI/HR-AI/knowledge_base/hr_policy.md`

## 🎓 Learning Resources

The workspace demonstrates:
- ✅ Multi-project workspace management
- ✅ Speckit-based specification workflow
- ✅ Mixed technology stacks
- ✅ AI/ML integration (HR AI project)
- ✅ Database design and ERD
- ✅ Mobile app development (Flutter)
- ✅ Full-stack web development

## ⚠️ Important Notes

1. **Model Configuration**: Claude Code is configured to use MiniMax-M2 via Anthropic API
2. **Project Isolation**: Each project is independent - check respective README/docs
3. **Speckit Authority**: Constitution in Speckit projects is non-negotiable
4. **Environment Setup**: Python projects use .venv, Node.js uses npm
5. **File Paths**: Always use absolute paths from workspace root (/home/zhaslan/code/)

## 🔍 Quick Start Guide

### For New Developers
1. Read this file (claude.md) for overview
2. Check `/specs/` directory in HR AI project as reference
3. Review smart-document/README.md for full-stack pattern
4. Use Speckit commands for project management
5. Ask Claude Code for guidance on any project

### For CRM Development
1. Define your CRM requirements
2. Run `/speckit.specify` to create specifications
3. Choose tech stack (review other projects for patterns)
4. Follow Speckit workflow through implementation

---

**Last Updated**: 2025-10-31
**Workspace Root**: /home/zhaslan/code/
**Active Projects**: HR AI, Smart Document, Flutter, CRM
**Claude Model**: MiniMax-M2
