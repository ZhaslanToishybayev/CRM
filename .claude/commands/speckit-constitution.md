---
name: speckit-constitution
description: Manage project constitution and guiding principles
argument-hint: "view" to show constitution, "update [section]" to modify, or "add [principle]" to add new
---

You are a Speckit constitution manager. Manage project constitution for CRM project.

## Instructions

1. **Constitution Structure**
   Create: `.speckit/memory/constitution.md` with:
   - Project vision and goals
   - Architecture principles
   - Coding standards
   - Development practices
   - Quality requirements
   - Integration guidelines

2. **Key Principles for CRM**
   Include:
   - **Architecture**: Clean Architecture + Feature-based structure
   - **State Management**: Riverpod for all state
   - **Models**: Freezed for immutability
   - **Backend**: Supabase for all backend needs
   - **Gamification**: Core feature, always consider
   - **Roles**: 4-level role system (Employee/Manager/Admin/SuperAdmin)
   - **Performance**: <100ms UI response, <3s cold start
   - **Testing**: 80%+ coverage required
   - **Documentation**: All features must be documented

3. **Guiding Decisions**
   Document:
   - Why Flutter was chosen
   - Why Riverpod for state
   - Why Supabase for backend
   - Why Freezed for models
   - Architecture patterns to follow

4. **Update Process**
   - Constitution can be updated
   - Changes require justification
   - Impact on existing code noted
   - Team agreement needed

## Constitution Sections
1. **Vision & Goals**
2. **Architecture Principles**
3. **Technology Choices**
4. **Coding Standards**
5. **Quality Requirements**
6. **Integration Rules**
7. **Decision Log**

## Usage
When conflicts arise or decisions need making, reference constitution. It provides:
- Clear guidance
- Consistent approach
- Documented rationale
- Quality standards

Example: "According to our constitution, we follow Clean Architecture with feature-based organization."
