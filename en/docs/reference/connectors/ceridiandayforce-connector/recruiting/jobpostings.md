# Working with Job Postings

[[Overview]](#overview)  [[Operation details]](#operation-details)  [[Sample configuration]](#sample-configuration)

### Overview 

The following operations allow you to retrieve job postings

| Operation | Description |
| ------------- |-------------|
|[GET Job Postings](#retrieving-job-postings)| Get the job postings available through the candidate portal. |

### Operation details

This section provides more details on each of the operations.

#### Retrieving Job Postings
We can use GET Job Postings operation with required parameters to search for job postings

**GET Job Postings**
```xml
<ceridiandayforce.getJobPostings>
    <companyName>{$ctx:companyName}</companyName>
    <parentCompanyName>{$ctx:parentCompanyName}</parentCompanyName>
    <internalJobBoardCode>{$ctx:internalJobBoardCode}</internalJobBoardCode>
    <includeActivePostingOnly>{$ctx:includeActivePostingOnly}</includeActivePostingOnly>
    <lastUpdateTimeFrom>{$ctx:lastUpdateTimeFrom}</lastUpdateTimeFrom>
    <lastUpdateTimeTo>{$ctx:lastUpdateTimeTo}</lastUpdateTimeTo>
    <datePostedFrom>{$ctx:datePostedFrom}</datePostedFrom>
    <datePostedTo>{$ctx:datePostedTo}</datePostedTo>
    <htmlDescription>{$ctx:htmlDescription}</htmlDescription>
</ceridiandayforce.getJobPostings>
```

**Properties**

* companyName (Optional- string): Company name. Example: XYZ Co.
* parentCompanyName (Optional - string): Parent Company name. Example: Ceridian
* internalJobBoardCode (Optional - string): XRefCode of Job Board. Example: CANDIDATEPORTAL
* includeActivePostingOnly (Optional - boolean): If true, then exclude inactive postings from the result. If False, then the 'Last Update Time From' and 'Last Update Time To' parameters are required and the range specified between the 'Last Update Time From' and 'Last Update Time To' parameters must not be larger than 1 month. Example: True
* lastUpdateTimeFrom (Optional - string): A starting timestamp of last updated job posting. Example: 2017-01-01T13:24:56
* lastUpdateTimeTo (Optional - string): An ending timestamp of last updated job posting. Example: 2017-02-01T13:24:56
* datePostedFrom (Optional - string): A starting timestamp of job posting date. Example: 2017-01-01T13:24:56
* datePostedTo (Optional - string): An ending timestamp of job posting date. Example: 2017-02-01T13:24:56
* htmlDescription (Optional - boolean): A flag to feed the jobs over with html formatting or plain text description

**Sample request**

Following is a sample request that can be handled by this operation.

```json
{
  "username": "DFWSTest",
  "password": "DFWSTest",
  "clientNamespace": "usconfigr57.dayforcehcm.com/Api/ddn",
  "apiVersion": "V1"
}
```

**Sample response**

Given below is a sample response for this operation.

```json
[
    {
        "Title": "Magasin 120 - Assistant gérant",
        "Description": "Objectif de poste d’assistant gérant de magasin : soutient ses clients par la formation du personnel, de l’achat et de l’étalage des produits.\n Tâches reliées du poste d’assistant gérant de magasin :\n -Former le personnel du magasin ; orienter les nouvelles embauches vers les produits et des matériaux de formation ; offrir des séances de formation ; l'évaluer les résultats et les besoins d’apprentissage des associés en collaboration avec le gérant du magasin ; élaborer et appliquer les nouvelles formations  produit. - Évalue la concurrence en visitant les magasins concurrents ; la collecte d'informations tels que le style, la qualité et les prix de marchandise compétitifs. - Achats d’inventaire via recherche de nouveaux produits ; anticiper l'intérêt des acheteurs ; négocier des réductions de prix de volume ; placer et accélérer les commandes ; confirmer la réception. - Attirer les clients par l’exposition de la marchandise en façade ; respecter les suggestions et les horaires d'étalage ; mise en place ou d’assemblage de propriétés d'étalages préfabriqués ; la préparation des marchandises affichées dans les fenêtres et vitrines et sur le plancher de vente. - Favoriser les ventes en présentant la marchandise et les produits aux clients. – Aider aux clients en fournissant des informations ; répondre aux questions ; obtenir la marchandise demandée ; effectuer les transactions de paiement ; la préparation des marchandises pour la livraison. – Préparer les soldes et la relation client en analysant les rapports et la catégorisation de renseignements sur les ventes ; identifier et étudier les plaintes et les suggestions de services rapportés par les clients. - Maintient l’environnement du magasin propre et sécuritaire par le développement et l'édition des itinéraires d'évacuation ; la  détermination et la documentation des emplacements de matériaux et de produits chimiques potentiellement dangereux. - Maintient l'inventaire en cochant la marchandise pour déterminer les niveaux de stock ; anticiper la demande. - Préparer des rapports par la collecte, l'analyse et la synthèse des informations. - Maintient un service de qualité en établissant et en appliquant des normes de l'organisation. - Maintenir une connaissance professionnelle et technique en participant à des ateliers éducatifs ; revue des publications professionnelles ; établir des réseaux personnels ; l'analyse comparative des meilleurs pratiques state-of-the-art ; participation à des associations professionnelles.  - Contribue à l'effort d'équipe.\n\n\nCareers at our Company...\n\nWhether you are taking the first step toward beginning your career or are a professional looking for an exciting new opportunity, we offer a wide array of challenging and creative paths.\nSee Other Job Opportunities",
        "ClientSiteName": "Client Careers Site",
        "ClientSiteXRefCode": "CANDIDATEPORTAL",
        "CompanyName": "XYZ Co..PRDemo3 - April18th-2017-Hf7\rUpdated life event form for emps\rUpdated Pay group pp#s",
        "ParentCompanyName": "XYZ Co..PRDemo3 - April18th-2017-Hf7\rUpdated life event form for emps\rUpdated Pay group pp#s",
        "JobDetailsUrl": "https://usconfigr57.dayforcehcm.com/CandidatePortal/fr-CA/ddn/Posting/View/9",
        "ApplyUrl": "https://usconfigr57.dayforcehcm.com/CandidatePortal/fr-CA/ddn/JobApplication?postingId=9",
        "City": "Alpharetta",
        "State": "GA",
        "Country": "USA",
        "PostalCode": "",
        "DatePosted": "2014-06-13T00:00:00",
        "LastUpdated": "2017-01-16T14:21:51.937",
        "ReferenceNumber": 9,
        "CultureCode": "fr-CA",
        "ParentRequisitionCode": 5,
        "JobType": 0,
        "TravelRequired": 0
    },
    {
        "Title": "Store 120 - Assistant Manager",
        "Description": "Job Purpose:\n   • Serves customers by training staff; purchasing and displaying products.\nJob Duties:\n   • Trains store staff by reviewing and revising orientation to products and sales training materials; delivering training sessions; reviewing staff job results and learning needs with retail store manager; developing and implementing new product training.\n   • Evaluates competition by visiting competing stores; gathering information such as style, quality, and prices of competitive merchandise.\n   • Purchases inventory by researching emerging products; anticipating buyer interest; negotiating volume price breaks; placing and expediting orders; verifying receipt.\n   • Attracts customers by originating display ideas; following display suggestions or schedules; constructing or assembling prefabricated display properties; producing merchandise displays in windows and showcases, and on sales floor.\n   • Promotes sales by demonstrating merchandise and products to customers.\n   • Helps customers by providing information; answering questions; obtaining merchandise requested; completing payment transactions; preparing merchandise for delivery.\n   • Prepares sales and customer relations reports by analyzing and categorizing sales information; identifying and investigating customer complaints and service suggestions.\n   • Maintains a safe and clean store environment by developing and publishing evacuation routes; determining and documenting locations of potentially dangerous materials and chemicals.\n   • Maintains inventory by checking merchandise to determine inventory levels; anticipating customer demand.\n   • Prepares reports by collecting, analyzing, and summarizing information.\n   • Maintains quality service by establishing and enforcing organization standards.\n   • Maintains professional and technical knowledge by attending educational workshops; reviewing professional publications; establishing personal networks; benchmarking state-of-the-art practices; participating in professional societies.\n   • Contributes to team effort by accomplishing related results as needed.\n\n\nCareers at our Company...\n\nWhether you are taking the first step toward beginning your career or are a professional looking for an exciting new opportunity, we offer a wide array of challenging and creative paths.\nSee Other Job Opportunities",
        "ClientSiteName": "Client Careers Site",
        "ClientSiteXRefCode": "CANDIDATEPORTAL",
        "CompanyName": "XYZ Co..PRDemo3 - April18th-2017-Hf7\rUpdated life event form for emps\rUpdated Pay group pp#s",
        "ParentCompanyName": "XYZ Co..PRDemo3 - April18th-2017-Hf7\rUpdated life event form for emps\rUpdated Pay group pp#s",
        "JobDetailsUrl": "https://usconfigr57.dayforcehcm.com/CandidatePortal/en-US/ddn/Posting/View/9",
        "ApplyUrl": "https://usconfigr57.dayforcehcm.com/CandidatePortal/en-US/ddn/JobApplication?postingId=9",
        "City": "Alpharetta",
        "State": "GA",
        "Country": "USA",
        "PostalCode": "",
        "DatePosted": "2014-06-13T00:00:00",
        "LastUpdated": "2017-01-16T14:21:51.937",
        "ReferenceNumber": 9,
        "CultureCode": "en-US",
        "ParentRequisitionCode": 5,
        "JobType": 0,
        "TravelRequired": 0
    },
    {
        "Title": "Magasin 110 – Associé aux accessoires",
        "Description": "But Vente aux détails : Sert clients, aide à sélectionner des produits.\n\nTâches reliées du poste de Vente aux détails : -\nAccueillir les clients et offrir de l'assistance. - Dirige clients vers les racks et\nles compteurs ; leur suggère des articles. - Conseille les clients en\nfournissant des informations sur les produits. - Aide à la clientèle à\neffectuer des sélections en bâtissant la confiance, offrant des suggestions\net des opinions. – Documente les ventes par la mise à jour des profils\nclient. - Traite les paiements ; traitement des chèques , espèces, et carte de\nmagasin ou autre cartes de crédit . – Avise les clients des rabais pour\nclients privilégiés. - Contribue à l'effort d'équipe.\n\n\nCareers at our Company...\n\nWhether you are taking the first step toward beginning your career or are a professional looking for an exciting new opportunity, we offer a wide array of challenging and creative paths.\nSee Other Job Opportunities",
        "ClientSiteName": "Client Careers Site",
        "ClientSiteXRefCode": "CANDIDATEPORTAL",
        "CompanyName": "XYZ Co..PRDemo3 - April18th-2017-Hf7\rUpdated life event form for emps\rUpdated Pay group pp#s",
        "ParentCompanyName": "XYZ Co..PRDemo3 - April18th-2017-Hf7\rUpdated life event form for emps\rUpdated Pay group pp#s",
        "JobDetailsUrl": "https://usconfigr57.dayforcehcm.com/CandidatePortal/fr-CA/ddn/Posting/View/17",
        "ApplyUrl": "https://usconfigr57.dayforcehcm.com/CandidatePortal/fr-CA/ddn/JobApplication?postingId=17",
        "City": "San Francisco",
        "State": "CA",
        "Country": "USA",
        "PostalCode": "",
        "DatePosted": "2014-06-13T00:00:00",
        "LastUpdated": "2017-01-16T14:19:41.263",
        "ReferenceNumber": 17,
        "CultureCode": "fr-CA",
        "ParentRequisitionCode": 3,
        "JobType": 0,
        "TravelRequired": 0
    },
    {
        "Title": "Store 110 - Accessories Associate",
        "Description": "Job Purpose:\n   • Serves customers by helping them select products.\nJob Duties:\n   • Welcomes customers by greeting them; offering them assistance.\n   • Directs customers by escorting them to racks and counters; suggesting items.\n   • Advises customers by providing information on products.\n   • Helps customer make selections by building customer confidence; offering suggestions and opinions.\n   • Documents sale by creating or updating customer profile records.\n   • Processes payments by totaling purchases; processing checks, cash, and store or other credit cards.\n   • Keeps clientele informed by notifying them of preferred customer sales and future merchandise of potential interest.\n   • Contributes to team effort by accomplishing related results as needed.\nRetail Salesperson Skills and Qualifications:\n   • Listening\n   • Customer Service\n   • Meeting Sales Goals\n   • Selling to Customer Needs\n   • Product Knowledge\n   • Verbal Communication\n\n\nCareers at our Company...\n\nWhether you are taking the first step toward beginning your career or are a professional looking for an exciting new opportunity, we offer a wide array of challenging and creative paths.\nSee Other Job Opportunities",
        "ClientSiteName": "Client Careers Site",
        "ClientSiteXRefCode": "CANDIDATEPORTAL",
        "CompanyName": "XYZ Co..PRDemo3 - April18th-2017-Hf7\rUpdated life event form for emps\rUpdated Pay group pp#s",
        "ParentCompanyName": "XYZ Co..PRDemo3 - April18th-2017-Hf7\rUpdated life event form for emps\rUpdated Pay group pp#s",
        "JobDetailsUrl": "https://usconfigr57.dayforcehcm.com/CandidatePortal/en-US/ddn/Posting/View/17",
        "ApplyUrl": "https://usconfigr57.dayforcehcm.com/CandidatePortal/en-US/ddn/JobApplication?postingId=17",
        "City": "San Francisco",
        "State": "CA",
        "Country": "USA",
        "PostalCode": "",
        "DatePosted": "2014-06-13T00:00:00",
        "LastUpdated": "2017-01-16T14:19:41.263",
        "ReferenceNumber": 17,
        "CultureCode": "en-US",
        "ParentRequisitionCode": 3,
        "JobType": 0,
        "TravelRequired": 0
    },
    {
        "Title": "Magasin 110 - Associé - Hommes",
        "Description": "But Vente aux détails : Sert clients en les aidant à\nsélectionner des produits .\n\nTâches reliées du poste de Vente aux détails : - Accueillir\nles clients en leur offrant une assistance . - Dirige clients vers les racks et\nles compteurs ; leur suggère des articles. - Conseille les clients en\nfournissant des informations sur les produits . - Aide la clientèle à effectuer\ndes sélections en bâtissant la confiance des clients ; offrant des suggestions\net des opinions . – Documente les ventes en faisant la mise à jour des profils\nclient. - Traite les paiements; traitement des chèques , espèces, et carte de\nmagasin ou autre cartes de crédit . – Avise les clients des soldes pour clients\nprivilégiés. - Contribue à l'effort d'équipe en accomplissant des résultats\nconnexes au besoin .\n\n\nCareers at our Company...\n\nWhether you are taking the first step toward beginning your career or are a professional looking for an exciting new opportunity, we offer a wide array of challenging and creative paths.\nSee Other Job Opportunities",
        "ClientSiteName": "Client Careers Site",
        "ClientSiteXRefCode": "CANDIDATEPORTAL",
        "CompanyName": "XYZ Co..PRDemo3 - April18th-2017-Hf7\rUpdated life event form for emps\rUpdated Pay group pp#s",
        "ParentCompanyName": "XYZ Co..PRDemo3 - April18th-2017-Hf7\rUpdated life event form for emps\rUpdated Pay group pp#s",
        "JobDetailsUrl": "https://usconfigr57.dayforcehcm.com/CandidatePortal/fr-CA/ddn/Posting/View/19",
        "ApplyUrl": "https://usconfigr57.dayforcehcm.com/CandidatePortal/fr-CA/ddn/JobApplication?postingId=19",
        "City": "San Francisco",
        "State": "CA",
        "Country": "USA",
        "PostalCode": "",
        "DatePosted": "2014-06-13T00:00:00",
        "LastUpdated": "2017-01-16T14:11:50.573",
        "ReferenceNumber": 19,
        "CultureCode": "fr-CA",
        "ParentRequisitionCode": 2,
        "JobType": 0,
        "TravelRequired": 0
    },
    {
        "Title": "Store 110 - Men's Associate",
        "Description": "Job Purpose:\n   • Serves customers by helping them select products.\nJob Duties:\n   • Welcomes customers by greeting them; offering them assistance.\n   • Directs customers by escorting them to racks and counters; suggesting items.\n   • Advises customers by providing information on products.\n   • Helps customer make selections by building customer confidence; offering suggestions and opinions.\n   • Documents sale by creating or updating customer profile records.\n   • Processes payments by totaling purchases; processing checks, cash, and store or other credit cards.\n   • Keeps clientele informed by notifying them of preferred customer sales and future merchandise of potential interest.\n   • Contributes to team effort by accomplishing related results as needed.\nRetail Salesperson Skills and Qualifications:\n   • Listening\n   • Customer Service\n   • Meeting Sales Goals\n   • Selling to Customer Needs\n   • Product Knowledge\n   • Verbal Communication\n\n\nCareers at our Company...\n\nWhether you are taking the first step toward beginning your career or are a professional looking for an exciting new opportunity, we offer a wide array of challenging and creative paths.\nSee Other Job Opportunities",
        "ClientSiteName": "Client Careers Site",
        "ClientSiteXRefCode": "CANDIDATEPORTAL",
        "CompanyName": "XYZ Co..PRDemo3 - April18th-2017-Hf7\rUpdated life event form for emps\rUpdated Pay group pp#s",
        "ParentCompanyName": "XYZ Co..PRDemo3 - April18th-2017-Hf7\rUpdated life event form for emps\rUpdated Pay group pp#s",
        "JobDetailsUrl": "https://usconfigr57.dayforcehcm.com/CandidatePortal/en-US/ddn/Posting/View/19",
        "ApplyUrl": "https://usconfigr57.dayforcehcm.com/CandidatePortal/en-US/ddn/JobApplication?postingId=19",
        "City": "San Francisco",
        "State": "CA",
        "Country": "USA",
        "PostalCode": "",
        "DatePosted": "2014-06-13T00:00:00",
        "LastUpdated": "2017-01-16T14:11:50.573",
        "ReferenceNumber": 19,
        "CultureCode": "en-US",
        "ParentRequisitionCode": 2,
        "JobType": 0,
        "TravelRequired": 0
    },
    {
        "Title": "Magasin 120 - Associés des dames",
        "Description": "But Vente aux détails : Sert clients en les aidant à\nsélectionner des produits .\n\nTâches reliées du poste de Vente aux détails : - Accueillir\nles clients en leur offrant une assistance . - Dirige clients vers les racks et\nles compteurs ; leur suggère des articles. - Conseille les clients en\nfournissant des informations sur les produits . - Aide la clientèle à effectuer\ndes sélections en bâtissant la confiance des clients ; offrant des suggestions\net des opinions . – Documente les ventes en faisant la mise à jour des profils\nclient. - Traite les paiements; traitement des chèques , espèces, et carte de\nmagasin ou autre cartes de crédit . – Avise les clients des soldes pour clients\nprivilégiés. - Contribue à l'effort d'équipe en accomplissant des résultats\nconnexes au besoin .\n\n\nCareers at our Company...\n\nWhether you are taking the first step toward beginning your career or are a professional looking for an exciting new opportunity, we offer a wide array of challenging and creative paths.\nSee Other Job Opportunities",
        "ClientSiteName": "Client Careers Site",
        "ClientSiteXRefCode": "CANDIDATEPORTAL",
        "CompanyName": "XYZ Co..PRDemo3 - April18th-2017-Hf7\rUpdated life event form for emps\rUpdated Pay group pp#s",
        "ParentCompanyName": "XYZ Co..PRDemo3 - April18th-2017-Hf7\rUpdated life event form for emps\rUpdated Pay group pp#s",
        "JobDetailsUrl": "https://usconfigr57.dayforcehcm.com/CandidatePortal/fr-CA/ddn/Posting/View/21",
        "ApplyUrl": "https://usconfigr57.dayforcehcm.com/CandidatePortal/fr-CA/ddn/JobApplication?postingId=21",
        "AddressLine1": "11720 Amberpark Drive",
        "City": "Alpharetta",
        "State": "GA",
        "Country": "USA",
        "PostalCode": "30009",
        "DatePosted": "2014-06-13T00:00:00",
        "LastUpdated": "2017-01-16T14:17:45.723",
        "ReferenceNumber": 21,
        "CultureCode": "fr-CA",
        "ParentRequisitionCode": 1,
        "JobType": 0,
        "TravelRequired": 0
    },
    {
        "Title": "Store 120 - Womens Associate",
        "Description": "Job Purpose:\n   • Serves customers by helping them select products.\nJob Duties:\n   • Welcomes customers by greeting them; offering them assistance.\n   • Directs customers by escorting them to racks and counters; suggesting items.\n   • Advises customers by providing information on products.\n   • Helps customer make selections by building customer confidence; offering suggestions and opinions.\n   • Documents sale by creating or updating customer profile records.\n   • Processes payments by totaling purchases; processing checks, cash, and store or other credit cards.\n   • Keeps clientele informed by notifying them of preferred customer sales and future merchandise of potential interest.\n   • Contributes to team effort by accomplishing related results as needed.\nRetail Salesperson Skills and Qualifications:\n   • Listening\n   • Customer Service\n   • Meeting Sales Goals\n   • Selling to Customer Needs\n   • Product Knowledge\n   • Verbal Communication\n\n\nCareers at our Company...\n\nWhether you are taking the first step toward beginning your career or are a professional looking for an exciting new opportunity, we offer a wide array of challenging and creative paths.\nSee Other Job Opportunities",
        "ClientSiteName": "Client Careers Site",
        "ClientSiteXRefCode": "CANDIDATEPORTAL",
        "CompanyName": "XYZ Co..PRDemo3 - April18th-2017-Hf7\rUpdated life event form for emps\rUpdated Pay group pp#s",
        "ParentCompanyName": "XYZ Co..PRDemo3 - April18th-2017-Hf7\rUpdated life event form for emps\rUpdated Pay group pp#s",
        "JobDetailsUrl": "https://usconfigr57.dayforcehcm.com/CandidatePortal/en-US/ddn/Posting/View/21",
        "ApplyUrl": "https://usconfigr57.dayforcehcm.com/CandidatePortal/en-US/ddn/JobApplication?postingId=21",
        "AddressLine1": "11720 Amberpark Drive",
        "City": "Alpharetta",
        "State": "GA",
        "Country": "USA",
        "PostalCode": "30009",
        "DatePosted": "2014-06-13T00:00:00",
        "LastUpdated": "2017-01-16T14:17:45.723",
        "ReferenceNumber": 21,
        "CultureCode": "en-US",
        "ParentRequisitionCode": 1,
        "JobType": 0,
        "TravelRequired": 0
    },
    {
        "Title": "Store 118 - Store Manager",
        "Description": "Store Manager Job Purpose: Serves customers by providing merchandise; supervising staff.\nRetail Store Manager Job Duties: - Completes store operational requirements by scheduling and assigning employees; following up on work results. - Maintains store staff by recruiting, selecting, orienting, and training employees. - Maintains store staff job results by coaching, counseling, and disciplining employees; planning, monitoring, and appraising job results. - Achieves financial objectives by preparing an annual budget; scheduling expenditures; analyzing variances; initiating corrective actions. - Identifies current and future customer requirements by establishing rapport with potential and actual customers and other persons in a position to understand service requirements. - Ensures availability of merchandise and services by approving contracts; maintaining inventories. - Formulates pricing policies by reviewing merchandising activities; determining additional needed sales promotion; authorizing clearance sales; studying trends. - Markets merchandise by studying advertising, sales promotion, and display plans; analyzing operating and financial statements for profitability ratios. - Secures merchandise by implementing security systems and measures. - Protects employees and customers by providing a safe and clean store environment. - Maintains the stability and reputation of the store by complying with legal requirements. - Determines marketing strategy changes by reviewing operating and financial statements and departmental sales records. - Maintains professional and technical knowledge by attending educational workshops; reviewing professional publications; establishing personal networks; participating in professional societies. - Maintains operations by initiating, coordinating, and enforcing program, operational, and personnel policies and procedures. - Contributes to team effort by accomplishing related results as needed.",
        "ClientSiteName": "Client Careers Site",
        "ClientSiteXRefCode": "CANDIDATEPORTAL",
        "CompanyName": "XYZ Co..PRDemo3 - April18th-2017-Hf7\rUpdated life event form for emps\rUpdated Pay group pp#s",
        "ParentCompanyName": "XYZ Co..PRDemo3 - April18th-2017-Hf7\rUpdated life event form for emps\rUpdated Pay group pp#s",
        "JobDetailsUrl": "https://usconfigr57.dayforcehcm.com/CandidatePortal/en-US/ddn/Posting/View/33",
        "ApplyUrl": "https://usconfigr57.dayforcehcm.com/CandidatePortal/en-US/ddn/JobApplication?postingId=33",
        "City": "Philadelphia",
        "State": "PA",
        "Country": "USA",
        "PostalCode": "",
        "DatePosted": "2014-06-16T00:00:00",
        "LastUpdated": "2016-04-15T11:54:07.283",
        "ReferenceNumber": 33,
        "CultureCode": "en-US",
        "ParentRequisitionCode": 6,
        "JobType": 0,
        "TravelRequired": 0
    },
    {
        "Title": "Team Member",
        "Description": "Team Member Job Purpose: Serves customers by helping them select products and delivering a great in-store experience.\n\nTeam Member Job Duties:\n- Welcomes customers by greeting them and offering them assistance.\n- Provides expert advice on the full range of brands and products available.\n- Offers solutions and in-store experiences that build customer confidence.\n- Documents sale by creating or updating customer profile records.\n- Processes payments by totaling purchases; processing checks, cash, and store or other credit cards.\n- Keeps customers informed by notifying them of sales and future products of potential interest.\n- Boosts store sales through refill and store presentation.\n- Works with the team to achieve store goals and objectives together.\n\nTeam Member Skills and Experience:\n- Recommended 2+ years of industry experience.\n- Some Customer Service experience required.\n- Strong communication skills and ability to explain product features and functionalities.\n- Experience with Point of Sale systems is a bonus.\n\nAs a Team Member, you will have the opportunity to be part of a dynamic and engaging work environment. The fast paced environment and strong company culture fosters both personal and professional growth. With consistent growth, our company provides many opportunities for advancement and encourages cross-functional experience.",
        "ClientSiteName": "Client Careers Site",
        "ClientSiteXRefCode": "CANDIDATEPORTAL",
        "CompanyName": "XYZ Co..PRDemo3 - April18th-2017-Hf7\rUpdated life event form for emps\rUpdated Pay group pp#s",
        "ParentCompanyName": "XYZ Co..PRDemo3 - April18th-2017-Hf7\rUpdated life event form for emps\rUpdated Pay group pp#s",
        "JobDetailsUrl": "https://usconfigr57.dayforcehcm.com/CandidatePortal/en-GB/ddn/Posting/View/65",
        "ApplyUrl": "https://usconfigr57.dayforcehcm.com/CandidatePortal/en-GB/ddn/JobApplication?postingId=65",
        "AddressLine1": "54 Park St",
        "City": "Sydney",
        "State": "NSW",
        "Country": "AU",
        "PostalCode": "2000",
        "DatePosted": "2017-08-03T00:00:00",
        "LastUpdated": "2017-08-03T14:34:14.993",
        "ReferenceNumber": 65,
        "CultureCode": "en-GB",
        "ParentRequisitionCode": 12,
        "JobType": 0,
        "TravelRequired": 0
    }
]
```

**Related Dayforce documentation**

[https://developers.dayforce.com/Build/API-Explorer/Recruiting/Get-Job-Postings.aspx](https://developers.dayforce.com/Build/API-Explorer/Recruiting/Get-Job-Postings.aspx)

### Sample configuration

Following example illustrates how to connect to Dayforce with the init operation and query operation.

1.Create a sample proxy as below :
```xml
<?xml version="1.0" encoding="UTF-8"?>
<proxy xmlns="http://ws.apache.org/ns/synapse"
       name="query"
       startOnLoad="true"
       statistics="disable"
       trace="disable"
       transports="http,https">
   <target>
      <inSequence>
         <log level="full" separator=","/>
         <property expression="json-eval($.username)" name="username"/>
         <property expression="json-eval($.password)" name="password"/>
         <property expression="json-eval($.clientNamespace)" name="clientNamespace"/>
         <property expression="json-eval($.apiVersion)" name="apiVersion"/>
         <ceridiandayforce.init>
            <username>{$ctx:username}</username>
            <password>{$ctx:password}</password>
            <clientNamespace>{$ctx:clientNamespace}</clientNamespace>
            <apiVersion>{$ctx:apiVersion}</apiVersion>
         </ceridiandayforce.init>
         <ceridiandayforce.getJobPostings/>
         <send/>
      </inSequence>
   </target>
   <description/>
</proxy>
                                
```

2.Create a json file named query.json and copy the configurations given below to it:

```json
{
  "username": "DFWSTest",
  "password": "DFWSTest",
  "clientNamespace": "usconfigr57.dayforcehcm.com/Api/ddn",
  "apiVersion": "V1"
}
```
3.Replace the credentials with your values.

4.Execute the following curl command:

```bash
curl http://localhost:8280/services/query -H "Content-Type: application/json" -d @query.json
```
5.Dayforce returns HTTP Code 200 with the following response body

```json
[
    {
        "Title": "Magasin 120 - Assistant gérant",
        "Description": "Objectif de poste d’assistant gérant de magasin : soutient ses clients par la formation du personnel, de l’achat et de l’étalage des produits.\n Tâches reliées du poste d’assistant gérant de magasin :\n -Former le personnel du magasin ; orienter les nouvelles embauches vers les produits et des matériaux de formation ; offrir des séances de formation ; l'évaluer les résultats et les besoins d’apprentissage des associés en collaboration avec le gérant du magasin ; élaborer et appliquer les nouvelles formations  produit. - Évalue la concurrence en visitant les magasins concurrents ; la collecte d'informations tels que le style, la qualité et les prix de marchandise compétitifs. - Achats d’inventaire via recherche de nouveaux produits ; anticiper l'intérêt des acheteurs ; négocier des réductions de prix de volume ; placer et accélérer les commandes ; confirmer la réception. - Attirer les clients par l’exposition de la marchandise en façade ; respecter les suggestions et les horaires d'étalage ; mise en place ou d’assemblage de propriétés d'étalages préfabriqués ; la préparation des marchandises affichées dans les fenêtres et vitrines et sur le plancher de vente. - Favoriser les ventes en présentant la marchandise et les produits aux clients. – Aider aux clients en fournissant des informations ; répondre aux questions ; obtenir la marchandise demandée ; effectuer les transactions de paiement ; la préparation des marchandises pour la livraison. – Préparer les soldes et la relation client en analysant les rapports et la catégorisation de renseignements sur les ventes ; identifier et étudier les plaintes et les suggestions de services rapportés par les clients. - Maintient l’environnement du magasin propre et sécuritaire par le développement et l'édition des itinéraires d'évacuation ; la  détermination et la documentation des emplacements de matériaux et de produits chimiques potentiellement dangereux. - Maintient l'inventaire en cochant la marchandise pour déterminer les niveaux de stock ; anticiper la demande. - Préparer des rapports par la collecte, l'analyse et la synthèse des informations. - Maintient un service de qualité en établissant et en appliquant des normes de l'organisation. - Maintenir une connaissance professionnelle et technique en participant à des ateliers éducatifs ; revue des publications professionnelles ; établir des réseaux personnels ; l'analyse comparative des meilleurs pratiques state-of-the-art ; participation à des associations professionnelles.  - Contribue à l'effort d'équipe.\n\n\nCareers at our Company...\n\nWhether you are taking the first step toward beginning your career or are a professional looking for an exciting new opportunity, we offer a wide array of challenging and creative paths.\nSee Other Job Opportunities",
        "ClientSiteName": "Client Careers Site",
        "ClientSiteXRefCode": "CANDIDATEPORTAL",
        "CompanyName": "XYZ Co..PRDemo3 - April18th-2017-Hf7\rUpdated life event form for emps\rUpdated Pay group pp#s",
        "ParentCompanyName": "XYZ Co..PRDemo3 - April18th-2017-Hf7\rUpdated life event form for emps\rUpdated Pay group pp#s",
        "JobDetailsUrl": "https://usconfigr57.dayforcehcm.com/CandidatePortal/fr-CA/ddn/Posting/View/9",
        "ApplyUrl": "https://usconfigr57.dayforcehcm.com/CandidatePortal/fr-CA/ddn/JobApplication?postingId=9",
        "City": "Alpharetta",
        "State": "GA",
        "Country": "USA",
        "PostalCode": "",
        "DatePosted": "2014-06-13T00:00:00",
        "LastUpdated": "2017-01-16T14:21:51.937",
        "ReferenceNumber": 9,
        "CultureCode": "fr-CA",
        "ParentRequisitionCode": 5,
        "JobType": 0,
        "TravelRequired": 0
    },
    {
        "Title": "Store 120 - Assistant Manager",
        "Description": "Job Purpose:\n   • Serves customers by training staff; purchasing and displaying products.\nJob Duties:\n   • Trains store staff by reviewing and revising orientation to products and sales training materials; delivering training sessions; reviewing staff job results and learning needs with retail store manager; developing and implementing new product training.\n   • Evaluates competition by visiting competing stores; gathering information such as style, quality, and prices of competitive merchandise.\n   • Purchases inventory by researching emerging products; anticipating buyer interest; negotiating volume price breaks; placing and expediting orders; verifying receipt.\n   • Attracts customers by originating display ideas; following display suggestions or schedules; constructing or assembling prefabricated display properties; producing merchandise displays in windows and showcases, and on sales floor.\n   • Promotes sales by demonstrating merchandise and products to customers.\n   • Helps customers by providing information; answering questions; obtaining merchandise requested; completing payment transactions; preparing merchandise for delivery.\n   • Prepares sales and customer relations reports by analyzing and categorizing sales information; identifying and investigating customer complaints and service suggestions.\n   • Maintains a safe and clean store environment by developing and publishing evacuation routes; determining and documenting locations of potentially dangerous materials and chemicals.\n   • Maintains inventory by checking merchandise to determine inventory levels; anticipating customer demand.\n   • Prepares reports by collecting, analyzing, and summarizing information.\n   • Maintains quality service by establishing and enforcing organization standards.\n   • Maintains professional and technical knowledge by attending educational workshops; reviewing professional publications; establishing personal networks; benchmarking state-of-the-art practices; participating in professional societies.\n   • Contributes to team effort by accomplishing related results as needed.\n\n\nCareers at our Company...\n\nWhether you are taking the first step toward beginning your career or are a professional looking for an exciting new opportunity, we offer a wide array of challenging and creative paths.\nSee Other Job Opportunities",
        "ClientSiteName": "Client Careers Site",
        "ClientSiteXRefCode": "CANDIDATEPORTAL",
        "CompanyName": "XYZ Co..PRDemo3 - April18th-2017-Hf7\rUpdated life event form for emps\rUpdated Pay group pp#s",
        "ParentCompanyName": "XYZ Co..PRDemo3 - April18th-2017-Hf7\rUpdated life event form for emps\rUpdated Pay group pp#s",
        "JobDetailsUrl": "https://usconfigr57.dayforcehcm.com/CandidatePortal/en-US/ddn/Posting/View/9",
        "ApplyUrl": "https://usconfigr57.dayforcehcm.com/CandidatePortal/en-US/ddn/JobApplication?postingId=9",
        "City": "Alpharetta",
        "State": "GA",
        "Country": "USA",
        "PostalCode": "",
        "DatePosted": "2014-06-13T00:00:00",
        "LastUpdated": "2017-01-16T14:21:51.937",
        "ReferenceNumber": 9,
        "CultureCode": "en-US",
        "ParentRequisitionCode": 5,
        "JobType": 0,
        "TravelRequired": 0
    },
    {
        "Title": "Magasin 110 – Associé aux accessoires",
        "Description": "But Vente aux détails : Sert clients, aide à sélectionner des produits.\n\nTâches reliées du poste de Vente aux détails : -\nAccueillir les clients et offrir de l'assistance. - Dirige clients vers les racks et\nles compteurs ; leur suggère des articles. - Conseille les clients en\nfournissant des informations sur les produits. - Aide à la clientèle à\neffectuer des sélections en bâtissant la confiance, offrant des suggestions\net des opinions. – Documente les ventes par la mise à jour des profils\nclient. - Traite les paiements ; traitement des chèques , espèces, et carte de\nmagasin ou autre cartes de crédit . – Avise les clients des rabais pour\nclients privilégiés. - Contribue à l'effort d'équipe.\n\n\nCareers at our Company...\n\nWhether you are taking the first step toward beginning your career or are a professional looking for an exciting new opportunity, we offer a wide array of challenging and creative paths.\nSee Other Job Opportunities",
        "ClientSiteName": "Client Careers Site",
        "ClientSiteXRefCode": "CANDIDATEPORTAL",
        "CompanyName": "XYZ Co..PRDemo3 - April18th-2017-Hf7\rUpdated life event form for emps\rUpdated Pay group pp#s",
        "ParentCompanyName": "XYZ Co..PRDemo3 - April18th-2017-Hf7\rUpdated life event form for emps\rUpdated Pay group pp#s",
        "JobDetailsUrl": "https://usconfigr57.dayforcehcm.com/CandidatePortal/fr-CA/ddn/Posting/View/17",
        "ApplyUrl": "https://usconfigr57.dayforcehcm.com/CandidatePortal/fr-CA/ddn/JobApplication?postingId=17",
        "City": "San Francisco",
        "State": "CA",
        "Country": "USA",
        "PostalCode": "",
        "DatePosted": "2014-06-13T00:00:00",
        "LastUpdated": "2017-01-16T14:19:41.263",
        "ReferenceNumber": 17,
        "CultureCode": "fr-CA",
        "ParentRequisitionCode": 3,
        "JobType": 0,
        "TravelRequired": 0
    },
    {
        "Title": "Store 110 - Accessories Associate",
        "Description": "Job Purpose:\n   • Serves customers by helping them select products.\nJob Duties:\n   • Welcomes customers by greeting them; offering them assistance.\n   • Directs customers by escorting them to racks and counters; suggesting items.\n   • Advises customers by providing information on products.\n   • Helps customer make selections by building customer confidence; offering suggestions and opinions.\n   • Documents sale by creating or updating customer profile records.\n   • Processes payments by totaling purchases; processing checks, cash, and store or other credit cards.\n   • Keeps clientele informed by notifying them of preferred customer sales and future merchandise of potential interest.\n   • Contributes to team effort by accomplishing related results as needed.\nRetail Salesperson Skills and Qualifications:\n   • Listening\n   • Customer Service\n   • Meeting Sales Goals\n   • Selling to Customer Needs\n   • Product Knowledge\n   • Verbal Communication\n\n\nCareers at our Company...\n\nWhether you are taking the first step toward beginning your career or are a professional looking for an exciting new opportunity, we offer a wide array of challenging and creative paths.\nSee Other Job Opportunities",
        "ClientSiteName": "Client Careers Site",
        "ClientSiteXRefCode": "CANDIDATEPORTAL",
        "CompanyName": "XYZ Co..PRDemo3 - April18th-2017-Hf7\rUpdated life event form for emps\rUpdated Pay group pp#s",
        "ParentCompanyName": "XYZ Co..PRDemo3 - April18th-2017-Hf7\rUpdated life event form for emps\rUpdated Pay group pp#s",
        "JobDetailsUrl": "https://usconfigr57.dayforcehcm.com/CandidatePortal/en-US/ddn/Posting/View/17",
        "ApplyUrl": "https://usconfigr57.dayforcehcm.com/CandidatePortal/en-US/ddn/JobApplication?postingId=17",
        "City": "San Francisco",
        "State": "CA",
        "Country": "USA",
        "PostalCode": "",
        "DatePosted": "2014-06-13T00:00:00",
        "LastUpdated": "2017-01-16T14:19:41.263",
        "ReferenceNumber": 17,
        "CultureCode": "en-US",
        "ParentRequisitionCode": 3,
        "JobType": 0,
        "TravelRequired": 0
    },
    {
        "Title": "Magasin 110 - Associé - Hommes",
        "Description": "But Vente aux détails : Sert clients en les aidant à\nsélectionner des produits .\n\nTâches reliées du poste de Vente aux détails : - Accueillir\nles clients en leur offrant une assistance . - Dirige clients vers les racks et\nles compteurs ; leur suggère des articles. - Conseille les clients en\nfournissant des informations sur les produits . - Aide la clientèle à effectuer\ndes sélections en bâtissant la confiance des clients ; offrant des suggestions\net des opinions . – Documente les ventes en faisant la mise à jour des profils\nclient. - Traite les paiements; traitement des chèques , espèces, et carte de\nmagasin ou autre cartes de crédit . – Avise les clients des soldes pour clients\nprivilégiés. - Contribue à l'effort d'équipe en accomplissant des résultats\nconnexes au besoin .\n\n\nCareers at our Company...\n\nWhether you are taking the first step toward beginning your career or are a professional looking for an exciting new opportunity, we offer a wide array of challenging and creative paths.\nSee Other Job Opportunities",
        "ClientSiteName": "Client Careers Site",
        "ClientSiteXRefCode": "CANDIDATEPORTAL",
        "CompanyName": "XYZ Co..PRDemo3 - April18th-2017-Hf7\rUpdated life event form for emps\rUpdated Pay group pp#s",
        "ParentCompanyName": "XYZ Co..PRDemo3 - April18th-2017-Hf7\rUpdated life event form for emps\rUpdated Pay group pp#s",
        "JobDetailsUrl": "https://usconfigr57.dayforcehcm.com/CandidatePortal/fr-CA/ddn/Posting/View/19",
        "ApplyUrl": "https://usconfigr57.dayforcehcm.com/CandidatePortal/fr-CA/ddn/JobApplication?postingId=19",
        "City": "San Francisco",
        "State": "CA",
        "Country": "USA",
        "PostalCode": "",
        "DatePosted": "2014-06-13T00:00:00",
        "LastUpdated": "2017-01-16T14:11:50.573",
        "ReferenceNumber": 19,
        "CultureCode": "fr-CA",
        "ParentRequisitionCode": 2,
        "JobType": 0,
        "TravelRequired": 0
    },
    {
        "Title": "Store 110 - Men's Associate",
        "Description": "Job Purpose:\n   • Serves customers by helping them select products.\nJob Duties:\n   • Welcomes customers by greeting them; offering them assistance.\n   • Directs customers by escorting them to racks and counters; suggesting items.\n   • Advises customers by providing information on products.\n   • Helps customer make selections by building customer confidence; offering suggestions and opinions.\n   • Documents sale by creating or updating customer profile records.\n   • Processes payments by totaling purchases; processing checks, cash, and store or other credit cards.\n   • Keeps clientele informed by notifying them of preferred customer sales and future merchandise of potential interest.\n   • Contributes to team effort by accomplishing related results as needed.\nRetail Salesperson Skills and Qualifications:\n   • Listening\n   • Customer Service\n   • Meeting Sales Goals\n   • Selling to Customer Needs\n   • Product Knowledge\n   • Verbal Communication\n\n\nCareers at our Company...\n\nWhether you are taking the first step toward beginning your career or are a professional looking for an exciting new opportunity, we offer a wide array of challenging and creative paths.\nSee Other Job Opportunities",
        "ClientSiteName": "Client Careers Site",
        "ClientSiteXRefCode": "CANDIDATEPORTAL",
        "CompanyName": "XYZ Co..PRDemo3 - April18th-2017-Hf7\rUpdated life event form for emps\rUpdated Pay group pp#s",
        "ParentCompanyName": "XYZ Co..PRDemo3 - April18th-2017-Hf7\rUpdated life event form for emps\rUpdated Pay group pp#s",
        "JobDetailsUrl": "https://usconfigr57.dayforcehcm.com/CandidatePortal/en-US/ddn/Posting/View/19",
        "ApplyUrl": "https://usconfigr57.dayforcehcm.com/CandidatePortal/en-US/ddn/JobApplication?postingId=19",
        "City": "San Francisco",
        "State": "CA",
        "Country": "USA",
        "PostalCode": "",
        "DatePosted": "2014-06-13T00:00:00",
        "LastUpdated": "2017-01-16T14:11:50.573",
        "ReferenceNumber": 19,
        "CultureCode": "en-US",
        "ParentRequisitionCode": 2,
        "JobType": 0,
        "TravelRequired": 0
    },
    {
        "Title": "Magasin 120 - Associés des dames",
        "Description": "But Vente aux détails : Sert clients en les aidant à\nsélectionner des produits .\n\nTâches reliées du poste de Vente aux détails : - Accueillir\nles clients en leur offrant une assistance . - Dirige clients vers les racks et\nles compteurs ; leur suggère des articles. - Conseille les clients en\nfournissant des informations sur les produits . - Aide la clientèle à effectuer\ndes sélections en bâtissant la confiance des clients ; offrant des suggestions\net des opinions . – Documente les ventes en faisant la mise à jour des profils\nclient. - Traite les paiements; traitement des chèques , espèces, et carte de\nmagasin ou autre cartes de crédit . – Avise les clients des soldes pour clients\nprivilégiés. - Contribue à l'effort d'équipe en accomplissant des résultats\nconnexes au besoin .\n\n\nCareers at our Company...\n\nWhether you are taking the first step toward beginning your career or are a professional looking for an exciting new opportunity, we offer a wide array of challenging and creative paths.\nSee Other Job Opportunities",
        "ClientSiteName": "Client Careers Site",
        "ClientSiteXRefCode": "CANDIDATEPORTAL",
        "CompanyName": "XYZ Co..PRDemo3 - April18th-2017-Hf7\rUpdated life event form for emps\rUpdated Pay group pp#s",
        "ParentCompanyName": "XYZ Co..PRDemo3 - April18th-2017-Hf7\rUpdated life event form for emps\rUpdated Pay group pp#s",
        "JobDetailsUrl": "https://usconfigr57.dayforcehcm.com/CandidatePortal/fr-CA/ddn/Posting/View/21",
        "ApplyUrl": "https://usconfigr57.dayforcehcm.com/CandidatePortal/fr-CA/ddn/JobApplication?postingId=21",
        "AddressLine1": "11720 Amberpark Drive",
        "City": "Alpharetta",
        "State": "GA",
        "Country": "USA",
        "PostalCode": "30009",
        "DatePosted": "2014-06-13T00:00:00",
        "LastUpdated": "2017-01-16T14:17:45.723",
        "ReferenceNumber": 21,
        "CultureCode": "fr-CA",
        "ParentRequisitionCode": 1,
        "JobType": 0,
        "TravelRequired": 0
    },
    {
        "Title": "Store 120 - Womens Associate",
        "Description": "Job Purpose:\n   • Serves customers by helping them select products.\nJob Duties:\n   • Welcomes customers by greeting them; offering them assistance.\n   • Directs customers by escorting them to racks and counters; suggesting items.\n   • Advises customers by providing information on products.\n   • Helps customer make selections by building customer confidence; offering suggestions and opinions.\n   • Documents sale by creating or updating customer profile records.\n   • Processes payments by totaling purchases; processing checks, cash, and store or other credit cards.\n   • Keeps clientele informed by notifying them of preferred customer sales and future merchandise of potential interest.\n   • Contributes to team effort by accomplishing related results as needed.\nRetail Salesperson Skills and Qualifications:\n   • Listening\n   • Customer Service\n   • Meeting Sales Goals\n   • Selling to Customer Needs\n   • Product Knowledge\n   • Verbal Communication\n\n\nCareers at our Company...\n\nWhether you are taking the first step toward beginning your career or are a professional looking for an exciting new opportunity, we offer a wide array of challenging and creative paths.\nSee Other Job Opportunities",
        "ClientSiteName": "Client Careers Site",
        "ClientSiteXRefCode": "CANDIDATEPORTAL",
        "CompanyName": "XYZ Co..PRDemo3 - April18th-2017-Hf7\rUpdated life event form for emps\rUpdated Pay group pp#s",
        "ParentCompanyName": "XYZ Co..PRDemo3 - April18th-2017-Hf7\rUpdated life event form for emps\rUpdated Pay group pp#s",
        "JobDetailsUrl": "https://usconfigr57.dayforcehcm.com/CandidatePortal/en-US/ddn/Posting/View/21",
        "ApplyUrl": "https://usconfigr57.dayforcehcm.com/CandidatePortal/en-US/ddn/JobApplication?postingId=21",
        "AddressLine1": "11720 Amberpark Drive",
        "City": "Alpharetta",
        "State": "GA",
        "Country": "USA",
        "PostalCode": "30009",
        "DatePosted": "2014-06-13T00:00:00",
        "LastUpdated": "2017-01-16T14:17:45.723",
        "ReferenceNumber": 21,
        "CultureCode": "en-US",
        "ParentRequisitionCode": 1,
        "JobType": 0,
        "TravelRequired": 0
    },
    {
        "Title": "Store 118 - Store Manager",
        "Description": "Store Manager Job Purpose: Serves customers by providing merchandise; supervising staff.\nRetail Store Manager Job Duties: - Completes store operational requirements by scheduling and assigning employees; following up on work results. - Maintains store staff by recruiting, selecting, orienting, and training employees. - Maintains store staff job results by coaching, counseling, and disciplining employees; planning, monitoring, and appraising job results. - Achieves financial objectives by preparing an annual budget; scheduling expenditures; analyzing variances; initiating corrective actions. - Identifies current and future customer requirements by establishing rapport with potential and actual customers and other persons in a position to understand service requirements. - Ensures availability of merchandise and services by approving contracts; maintaining inventories. - Formulates pricing policies by reviewing merchandising activities; determining additional needed sales promotion; authorizing clearance sales; studying trends. - Markets merchandise by studying advertising, sales promotion, and display plans; analyzing operating and financial statements for profitability ratios. - Secures merchandise by implementing security systems and measures. - Protects employees and customers by providing a safe and clean store environment. - Maintains the stability and reputation of the store by complying with legal requirements. - Determines marketing strategy changes by reviewing operating and financial statements and departmental sales records. - Maintains professional and technical knowledge by attending educational workshops; reviewing professional publications; establishing personal networks; participating in professional societies. - Maintains operations by initiating, coordinating, and enforcing program, operational, and personnel policies and procedures. - Contributes to team effort by accomplishing related results as needed.",
        "ClientSiteName": "Client Careers Site",
        "ClientSiteXRefCode": "CANDIDATEPORTAL",
        "CompanyName": "XYZ Co..PRDemo3 - April18th-2017-Hf7\rUpdated life event form for emps\rUpdated Pay group pp#s",
        "ParentCompanyName": "XYZ Co..PRDemo3 - April18th-2017-Hf7\rUpdated life event form for emps\rUpdated Pay group pp#s",
        "JobDetailsUrl": "https://usconfigr57.dayforcehcm.com/CandidatePortal/en-US/ddn/Posting/View/33",
        "ApplyUrl": "https://usconfigr57.dayforcehcm.com/CandidatePortal/en-US/ddn/JobApplication?postingId=33",
        "City": "Philadelphia",
        "State": "PA",
        "Country": "USA",
        "PostalCode": "",
        "DatePosted": "2014-06-16T00:00:00",
        "LastUpdated": "2016-04-15T11:54:07.283",
        "ReferenceNumber": 33,
        "CultureCode": "en-US",
        "ParentRequisitionCode": 6,
        "JobType": 0,
        "TravelRequired": 0
    },
    {
        "Title": "Team Member",
        "Description": "Team Member Job Purpose: Serves customers by helping them select products and delivering a great in-store experience.\n\nTeam Member Job Duties:\n- Welcomes customers by greeting them and offering them assistance.\n- Provides expert advice on the full range of brands and products available.\n- Offers solutions and in-store experiences that build customer confidence.\n- Documents sale by creating or updating customer profile records.\n- Processes payments by totaling purchases; processing checks, cash, and store or other credit cards.\n- Keeps customers informed by notifying them of sales and future products of potential interest.\n- Boosts store sales through refill and store presentation.\n- Works with the team to achieve store goals and objectives together.\n\nTeam Member Skills and Experience:\n- Recommended 2+ years of industry experience.\n- Some Customer Service experience required.\n- Strong communication skills and ability to explain product features and functionalities.\n- Experience with Point of Sale systems is a bonus.\n\nAs a Team Member, you will have the opportunity to be part of a dynamic and engaging work environment. The fast paced environment and strong company culture fosters both personal and professional growth. With consistent growth, our company provides many opportunities for advancement and encourages cross-functional experience.",
        "ClientSiteName": "Client Careers Site",
        "ClientSiteXRefCode": "CANDIDATEPORTAL",
        "CompanyName": "XYZ Co..PRDemo3 - April18th-2017-Hf7\rUpdated life event form for emps\rUpdated Pay group pp#s",
        "ParentCompanyName": "XYZ Co..PRDemo3 - April18th-2017-Hf7\rUpdated life event form for emps\rUpdated Pay group pp#s",
        "JobDetailsUrl": "https://usconfigr57.dayforcehcm.com/CandidatePortal/en-GB/ddn/Posting/View/65",
        "ApplyUrl": "https://usconfigr57.dayforcehcm.com/CandidatePortal/en-GB/ddn/JobApplication?postingId=65",
        "AddressLine1": "54 Park St",
        "City": "Sydney",
        "State": "NSW",
        "Country": "AU",
        "PostalCode": "2000",
        "DatePosted": "2017-08-03T00:00:00",
        "LastUpdated": "2017-08-03T14:34:14.993",
        "ReferenceNumber": 65,
        "CultureCode": "en-GB",
        "ParentRequisitionCode": 12,
        "JobType": 0,
        "TravelRequired": 0
    }
]
```
