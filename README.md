# Transactions app

To run app you need to provide Appwrite api keys.
1. Create file keys.dart in root lib folder.
2. Provide needed values:
 
String appwriteEndpoint = 'https://cloud.appwrite.io/v1';

String appwriteProjectId = 'YOUR_PROJECT_ID';

String databaseId = 'YOUR_DATABASE_ID';

String collectionId = 'YOUR_TRANSACTIONS_COLLECTION_ID';

Configure your appwire service. Create database and collection.
Collection Attributes:
 <p align="center">
 <img align="center" alt="keystrokes" src="https://raw.githubusercontent.com/pawelwiklo/transactions/master/repo_images/appwrite_transaction_arrtibutes.png" />
 </p>

# App Features

- Log In and Account create validation. Both on local side - password match, password length and server side response - invalid email, email already in use.

 <p align="center">
 <img align="center" alt="keystrokes" src="https://raw.githubusercontent.com/pawelwiklo/transactions/master/repo_images/transactions_auth_validations.gif" />
 </p>

 - Show transaction details and delete transaction.
 <p align="center">
 <img align="center" alt="keystrokes" src="https://raw.githubusercontent.com/pawelwiklo/transactions/master/repo_images/transactions_delete.gif" />
 </p>

  - Add new transaction. 
 <p align="center">
 <img align="center" alt="keystrokes" src="https://raw.githubusercontent.com/pawelwiklo/transactions/master/repo_images/transactions_add.gif" />
 </p>

# Technical specifications
- Redux as state management.
- Redux middleware to perform API requests and business logic
- Go_router as app screens navigation.
- Appwrite as online auth system and database.
- Fyncfusion_flutter_charts lib in role of Donut diagram.
- Json_serializable and json_annotation and build_runner for models toJson/fromJson
- Intl as DateTime formatter
- UUID just as UUID
