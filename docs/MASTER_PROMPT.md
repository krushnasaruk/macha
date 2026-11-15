# CaféOS — Master Development Prompt

> **Note:** This document serves as the master prompt specification reference for the CaféOS project. The detailed, staged roadmap, architecture decision records (ADRs), definition of done, and execution milestones are tracked and maintained in [EXECUTION_PLAN.md](file:///c:/Users/Krushna/OneDrive/Documents/freelancing/kharadi/cafeOS/docs/EXECUTION_PLAN.md) and [PROGRESS.md](file:///c:/Users/Krushna/OneDrive/Documents/freelancing/kharadi/cafeOS/docs/PROGRESS.md).

## Project Overview
CaféOS is an enterprise-grade, offline-first Point of Sale (POS), Kitchen Display System (KDS), Table Management, and Café Inventory system built with Flutter and Supabase.

### Core Architecture Highlights
1. **Offline-First:** Drift (SQLite) local storage with outbox pattern for transactional consistency.
2. **Deterministic Money:** Integer minor units (paise) backed `Money` value type; pure Dart pricing engine.
3. **Multi-Tenant & Multi-Branch:** Partitioned by `tenant_id` and `branch_id`, with strict RLS enforcement.
4. **Idempotent Critical Operations:** Financial, order settlement, and stock deductions execute via atomic, idempotent server-side RPCs or verified local transactions synced via UUIDs.
5. **Modern Flutter Architecture:** Feature-first structure, Riverpod state management, GoRouter, adaptive phone/tablet/desktop layouts.
