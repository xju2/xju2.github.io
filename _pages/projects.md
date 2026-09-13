---
layout: archive
title: "Software & Projects"
permalink: /projects/
author_profile: true
excerpt: "Agentic workflows, scientific foundation models, and shared inference infrastructure."
---

I develop systems that connect machine learning to scientific data and computing. These projects span active research and deployed infrastructure; the descriptions distinguish their goals from published results.

## HepGateway

**Focus: agentic AI for scientific workflows · Active development**

Scientists need to coordinate data access, software environments, job execution, and interpretation. I am developing HepGateway to bring these interactions into a unified platform connected to HPC resources, with NERSC as the initial deployment setting.

An analysis is represented as a typed executable graph. Work nodes use AI agents to transform input artifacts into schema-validated outputs. Control nodes evaluate outputs and decide what runs next, including bounded revision loops. AI agents carry out workflow actions; machine-learning models remain scientific tools that those workflows can use.

The evaluation goal is to reproduce a published analysis and measure manual interventions, time to a successful result, and provenance coverage. This is ongoing work, with evaluation results still to come.

[Discuss HepGateway](mailto:xju@lbl.gov?subject=HepGateway)

## Foundational Universe

**Focus: foundation models for scientific fields · Research in progress**

Large simulations contain rich structure that is expensive to store and difficult to model jointly. I am studying compact learned representations of Nyx cosmological simulations, which contain six physical fields defined on a three-dimensional grid.

The approach uses a VQ-VAE with residual vector quantization to turn simulation chunks into discrete tokens. A hierarchical autoregressive model is being developed to capture dependencies across spatial regions, sites, and quantization levels. The goal is to support high-fidelity generation and transfer to downstream scientific tasks while testing what physical information survives compression.

[Discuss scientific field models](mailto:xju@lbl.gov?subject=Foundational%20Universe)

## Inference as a Service

**Focus: shared ML inference and HPC integration · Deployment and performance studies**

Physics applications increasingly depend on models that benefit from GPUs, while their event processing may run on CPUs. I develop inference services and client integration that let multiple applications share accelerator resources.

The work combines NVIDIA Triton Inference Server with ATLAS Athena integration and deployments at NERSC and the University of Chicago Analysis Facility. Current studies examine concurrency, load balancing, autoscaling, and end-to-end performance. Athena manages event processing while remote services execute machine-learning inference and, in tracking applications, reconstruction stages.

A published tracking-as-a-service study provides a concrete example of this direction. Ongoing Athena–Triton work extends the integration and its performance evaluation.

[Tracking-as-a-service paper](https://arxiv.org/abs/2501.05520) · [Contact me about integration](mailto:xju@lbl.gov?subject=Inference%20as%20a%20Service)

## Tracking and reconstruction

**Focus: learning from detector measurements · Published methods and ongoing development**

Track finding turns large point clouds of detector measurements into particle trajectories. My work explores graph neural networks and token-based Transformer models for this task, including ExaTrkX, GNN4ITk, and TrackSorter. These methods connect representation learning to the physics and computing requirements of reconstruction.

[TrackSorter](https://arxiv.org/abs/2407.21290) · [Geometric deep learning for hyperon tracking](https://arxiv.org/abs/2503.14305) · [Recent presentation]({{ '/talks/2025-11-09' | relative_url }})

For publicly available software, see my [GitHub profile](https://github.com/xju2). For projects without a public release, please [get in touch](mailto:xju@lbl.gov).
