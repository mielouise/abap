# SAP RAP Inventory Management

A warehouse inventory management project built with SAP ABAP Cloud and the ABAP RESTful Application Programming Model (RAP). It models products, warehouses, and stock levels, and exposes business data through OData V4 services for use by SAP Fiori or other clients.

## Features

- **Product management** — product names, descriptions, and categories.
- **Warehouse management** — warehouse details, including address, city, and postal code.
- **Stock tracking** — stock quantities linked to products and warehouses.
- **CDS data models** — root view entities and consumption views for the business objects.
- **RAP business objects** — behavior definitions and implementations for product, warehouse, and stock entities.
- **OData V4 services** — service definitions and bindings for exposing the business objects.
- **Sample data utilities** — ABAP classes for loading example product, warehouse, and stock data.
- **ABAP Unit tests** — tests for selected business logic.

## Technology

- SAP ABAP Cloud
- ABAP RESTful Application Programming Model (RAP)
- ABAP CDS
- OData V4
- abapGit

## Repository structure

```text
.
├── .abapgit.xml
└── src/
    ├── CDS view entities and value helps
    ├── RAP behavior definitions and implementations
    ├── OData service definitions and bindings
    ├── database tables and domains
    └── ABAP classes, including data loaders and tests
```

The repository is organized as an abapGit project. The ABAP development objects are located in `src/`.

## Getting started

This project requires access to an SAP ABAP Cloud system with the ABAP Development Tools (ADT) or another compatible development environment. The repository contains ABAP backend objects; it is not a standalone application that can be run locally.

1. In your SAP system, install or open the project using **abapGit**.
2. Clone/import this repository into an appropriate ABAP package.
3. Activate the imported database tables, CDS entities, RAP behavior objects, service definitions, and service bindings in dependency order.
4. Review the sample data loader classes before running them. The general stock data loader clears the stock table before inserting its sample records.
5. Publish the OData V4 service bindings in your system and use the generated service URLs with your client or SAP Fiori application.

Exact activation steps and available features may depend on the ABAP Cloud environment and its release.

## Data model

The main business objects are:

| Entity | Purpose |
| --- | --- |
| Product | Stores product identification, name, description, and category. |
| Warehouse | Stores warehouse identification and location details. |
| Stock | Stores the quantity of a product at a warehouse. |

Stock records associate a product with a warehouse and track the available amount. The CDS model also exposes relationships between stock, products, and warehouses.

## OData services

The source includes separate service definitions for product and warehouse management, as well as RAP service bindings for the business objects. Activate and publish the relevant service bindings in your ABAP system to obtain the runtime OData V4 endpoints.

## Sample data

The repository includes executable ABAP classes for initializing example data. Run these only in a development or test environment and review their implementation first. In particular, the stock data loader deletes existing rows from the stock table before inserting its sample data.

## Tests

ABAP Unit test classes are included for selected functionality. Run them in ADT after importing and activating the project in an SAP system.

## Author

This project is developed and maintained by Mie Louise (mielouise).

GitHub: https://github.com/mielouise

## License

No license has been specified for this repository yet. Unless a license is added, all rights remain with the copyright holder and reuse may be restricted.
