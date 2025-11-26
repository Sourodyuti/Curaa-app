-----

# 🐾 Curaa: The Pet Care & Wellness App

### *Engineering the Future of Pet Parenting*

## 📖 Project Abstract

**Curaa** is not just an app; it is a **digital sanctuary for pet parents**. We are building a unified mobile ecosystem that bridges the fragmented gap between pet owners, veterinary professionals, and premium product supply chains.

This repository hosts the **source code** for the upcoming client-side mobile application. It represents a ground-up engineering effort to digitize pet care, integrating service booking (Grooming/Vet/Sitting) with a robust e-commerce layer.

> **⚠️ Status Note:** This project is currently **Under Active Development**. The codebase is fluid, with features being architected, refactored, and optimized daily. This is the staging ground for the next big thing in PetTech.

## The Vision

We are engineering a platform where "Pawsome Care" meets "Pixel-Perfect Performance."

  * **For Parents:** A seamless interface to manage their pet's lifecycle—from nutrition to healthcare.
  * **For Vets & Groomers:** A streamlined dashboard to manage appointments and medical history.
  * **For the Network:** A low-latency marketplace connecting demand with hyper-local supply.

## Architectural Core (Under the Hood)

The application is being constructed on a **Service-Oriented Architecture (SOA)**, designed to handle the complexity of scheduling, payments, and real-time tracking without compromising user experience.

### 1\. The Omni-Service Engine 

We are developing a dynamic routing module that handles diverse service verticals within a single codebase:

  * **Vet Wellness:** Logic for telemedicine integration and clinic appointment slot management.
  * **Grooming & Spa:** A booking heuristic that matches pet size/breed with service duration and specialist availability.
  * **Walking & Sitting:** Geolocation-based matching to find trusted caregivers in the user's vicinity.

### 2\. The Commerce Layer 

A fully integrated e-commerce stack is being woven into the app's fabric.

  * **Inventory Synchronization:** Real-time state management for product availability (Food, Toys, Accessories).
  * **Smart Cart Logic:** Session-persistent cart management with optimized checkout flows.

### 3\. The "Pet Profile" Matrix 

At the heart of the data model is the **Pet Entity**.

  * We are structuring the database schemas to hold complex biological data (Breed, Age, Medical History, Allergies) which informs the recommendation engine for food and services.

## Codebase Structure (Current State)

The repository is organized to support rapid feature iteration while maintaining clean separation of concerns:

  * **`lib/core/`**: The backbone. Contains shared utilities, theme constants (Curaa Brand Colors), and base network interceptors.
  * **`lib/features/auth/`**: The security gate. Handling OTP verification and secure user sessions.
  * **`lib/features/marketplace/`**: The logic driving the product listing, filtering, and cart operations.
  * **`lib/features/services/`**: The booking engines for Grooming, Vet visits, and Training.
  * **`lib/ui/`**: A library of reusable, pixel-perfect UI widgets designed to match the specific "Warm & Trusting" aesthetic of the Curaa brand.

## Roadmap: The Next Sprint

We are currently focused on stabilizing the core "Happy Path":

1.  **Authentication Handshake:** Finalizing the secure login/signup flow.
2.  **Service Discovery:** Polishing the UI for browsing services and viewing provider details.
3.  **Cart & Checkout:** Implementing the payment gateway integration sandboxes.

## Contribution & Protocol

As this is a **closed-source proprietary product in development**, access is restricted to the core engineering team.

  * **Branching Strategy:** We follow `feature/*` -\> `dev` -\> `main`.
  * **Code Style:** Strict linting rules are enforced to ensure the codebase remains scalable as we approach Beta launch.

-----

*Built with ❤️ for Pets by Sourodyuti.*
*Check out our vision at [curaa.co.in](https://curaa.co.in)*
