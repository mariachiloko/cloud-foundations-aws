# Phase 4 Architecture - ECS Fargate

## What We Are Doing

Phase 4 introduces containerized application delivery using Amazon ECS and AWS Fargate. The goal is to understand how a service can run containers without needing to manage the EC2 hosts directly.

This phase focuses on the operational building blocks rather than application code details:

- how containers are packaged
- how ECS schedules work
- how Fargate removes server management
- how the service integrates with networking, IAM, and logging

## Initial Mental Model

```text
User / Browser
  ↓
Load Balancer
  ↓
ECS Service
  ↓
Fargate Task
  ↓
CloudWatch Logs
```

## Core Components

### ECS Cluster

The cluster is the logical boundary for container workloads. It groups together the services and tasks that belong to this phase.

### Task Definition

A task definition is the blueprint for the containerized application. It describes:

- the image to run
- CPU and memory settings
- environment variables
- ports
- logging configuration

### Task

A task is a running instance of the task definition. In Fargate, AWS handles the compute layer that runs the task.

### ECS Service

The service keeps the requested number of tasks running and replaces tasks that fail. This is how the application stays available.

### Fargate

Fargate runs the task without requiring me to manage the worker nodes. That keeps the focus on the container configuration, not the host management.

### IAM

ECS tasks should use IAM roles for the permissions they need. This keeps the container workload aligned with the least-privilege model used in earlier phases.

### CloudWatch Logs

Logs are still important in this phase because containers need observable runtime output for troubleshooting.

## Why This Architecture Matters

Containers are common in real environments because they provide a repeatable packaging model for applications. ECS Fargate is especially useful when teams want the container benefits without the operational overhead of managing their own servers.

## Day 1 Focus

The first day should emphasize:

- conceptual understanding
- where ECS fits in the project
- how it compares with Lambda and EC2
- what problems Fargate solves

