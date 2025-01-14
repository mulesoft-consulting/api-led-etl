# api-led-etl
Example assets and supporting client facing material to demonstrate how to enable ETL within an API Led Architecture

# Enabling ETL Within an API Led Architecture

This example was evolved from assets created when reframing a potential customer from their legacy batch ETL approach towards using real-time APIs. In addition to showing the benefits of API Led and demonstrating the platform generally, we also had to demonstrate an ability to support transitional ETL and batch style scenarios.

Like many customers they needed to continue to support existing batch in- and out- feeds for legacy, tactical, and strategic platforms whilst moving towards an API Led Architecture over time. Their business data entities were also fragmented enough they needed to deal with MDM style synchronisation problems in the short term, but wouldn't always need or desire to manage this as part of the System or Process APIs in real-time. 

This example doesn't cover all the possible patterns for implementing target and transition state architectures to meet these requirements, but should be easy to tailor to a specific client's use cases.

## Metadata 
API Kit, Anypoint Platform, Studio, Database, Batch, Poll

## Use Case 
The organisation had a large number of point to point batch integrations using CSV files which meant most business process updates happened over a 24 to 48 hour period. Data was always out of date and manual data entry to spreadsheets led to large numbers of errors and reconcilliation problems. 

An initial candidate use case was to move product catalog pricing management to a realtime process for a limited number of users, whilst continuiung to support the existing batch process. 

**Current Process:**
1. An overnight batch job queries the product catalogue database. This generates a CSV of all products and pricing.
1. Another script picks up the file and emails it to all product managers.
1. The next day the product managers check pricing and make any updates for their products and send the file back to a mailbox.
1. A script drops the emailed CSV files into a folder for end of day processing.
1. At end of day another script checks each CSV file and merges any changes into a single new CSV file.
1. The new CSV is used to update the database.

**Initial Target Solution:**
1. Expose product catalogue information using a *Products* System API.
1. Support an update on the *Products* System API which targets price on a per-product basis.
1. Initially implement a Process API which implements the batch extract and input phases.
1. Next step planning: Mobile application to directly consume query products and update price.

## Requirements and Preparation Steps:
### Dependencies
You will need:
* An Anypoint account
* Studio
* Access to a MySQL environment.

## How to Run Example
1. Download the Assets from the [Repository](https://github.com/mulesoft-consulting/api-led-etl)

   You can just clone the repo locally to get access to everything. 
1. Update the [API Led ETL Presentation](https://github.com/mulesoft-consulting/api-led-etl/tree/master/docs/)

   Tailor the deck to the client's industry/use cases, as well as their systems and connectivity requirements. Likewise, update the further reading section.
1. Prepare the MySQL Database

   Amend the product information to align to the company's industry/use cases, if possible. [Scripts](https://github.com/mulesoft-consulting/api-led-etl/tree/master/resources/database) are provided for creating the tables and loading test data.
1. Prepare AnyPoint Platform

   Create a clean business group if you plan to demonstrate creating the API in Design Center. Otherwise either copy the API into Design Center and publish to Exchange so that you can pull it from the cloud, or you will need to import the API file from your local repo on project creation in Studio.
   
1. Follow the Demo Script

## Demo Script
1. The first part of the deck is standard API Led, and platform capabilities.

   Switch out to your environment to show the platform as you go, or update the deck to use slideware for this phase.

1. Talk through the additional slides discussing Poll and Batch capabilities.

   The slides cover two examples: Polling to create a product pricing report CSV, and Batch processing a pricing update file.
   1. Polling Report Generation
  
      **Key point is leveraging the System API rather than integrating directly to the backend System-Of-Record.**
      1. Generate the API project using the RAML specification either taken from Design Center or your local repo copy, depending how you did the Anypoint Platform walkthrough.
      1. Implement GET /products against the database. (Use the snippets file and example files as accelerators).
      1. You do not need to implement GET /products/{product_id} for this demo.
      1. Good Practice Demo: Ensure you externalise your configuration params for the database.
      1. Demonstrate running and calling the API to get a list of products from the database using a utility such as Postman.
      1. Create a new Mule Configuration File called "batch". Explain how in a real architecture this would sit better in a process API and this is a simplification for the demo.
      1. Implement the Poller flow:
       
         ![batchBuildPricingCSVReport](https://github.com/mulesoft-consulting/api-led-etl/blob/master/docs/batchBuildPricingCSVReport.png)
      1. Demonstrate file creation by running the Poller with a suitable polling period.
   1. Batch File Processing
  
      **Key point is leveraging the System API rather than integrating directly to the backend System-Of-Record.**
      1. Implement PUT /products/{product_id}/unit_cost against the database.
      1. Demonstrate calling the API to update pricing for a specific product, and see the changes propagate to the output file on next poll, as well as realtime calling the API using a utility such as Postman.
      1. Implement the Batch:
      
         ![batchProcessPricingUpdates](https://github.com/mulesoft-consulting/api-led-etl/blob/master/docs/batchProcessPriceUpdates.png)
      1. Demonstrate updating pricing on a previously generated file and having it load up, then generating an updated file automatically on next poll. Also use a utility such as Postman to demonstrate it is available in realtime too.
   1. Talk through extension possibilities including realtime pricing updates via an application, wrapping an approvals process in realtime, creating new products and archiving them, etc.

## Reference Material

| Resource | Description |
| -------- | ----------- |
| [/docs](https://github.com/mulesoft-consulting/api-led-etl/tree/master/docs)    | Image files for README. |
|          | Template Powerpoint presentation. |
| [/resources/database](https://github.com/mulesoft-consulting/api-led-etl/tree/master/resources/database) | Table creation and population scripts. |
| [/ resources](https://github.com/mulesoft-consulting/api-led-etl/tree/master/resources) | Exchange example markup text for asset. |
|             | Snippets file containing database select/updates, plus example transforms. |
|             | Example responses and input files for generating types and enabling Datasense. |

## Contact info
craig.bayley@mulesoft.com - Enhancement ideas welcome!
