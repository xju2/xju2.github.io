---
layout: archive
title: "Software & Projects"
permalink: /projects/
author_profile: true
excerpt: "Shared inference infrastructure and machine learning for particle tracking."
---

I develop systems that connect machine learning to scientific data and computing. This page highlights inference infrastructure and published reconstruction methods.

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

For publicly available software, see my [GitHub profile](https://github.com/xju2).
