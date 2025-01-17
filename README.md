# 💸 Exchange Bank App 💸

The Exchange Banking API is a feature-rich and real-time currency exchange platform. It enables users to create custom accounts, perform currency exchanges, and experience seamless banking operations powered by real-time data from the Narodowy Bank Polski API (NBP). All requests being made over HTTPS and returning JSON data. The App using SwiftUI and following an MV Pattern. [View Screenshots](#screenshots-section)

## Rest
https://github.com/CANWIA00/exchangeBankAPI

## API Reference
- Base url: http://localhost:8080/v1/
- All the endponints got secured with jwt token except Login and Register endpoints. So need to send also jwt token all the time via header.

#### Authentication

| Request Type | Path     | Description                |
| :-------- | :------- | :------------------------- |
| `POST` | `/auth/register` | To register to app  |
| `POST` | `/exchange/login` | To login to app |

#### User

| Request Type | Path     | Description                |
| :-------- | :------- | :------------------------- |
| `GET` | `/user` | Get user details  |

#### Account

| Request Type | Path     | Description                |
| :-------- | :------- | :------------------------- |
| `POST` | `/acount/pln` | To create pln account when you register to app first |
| `POST` | `/account` | Create an account with foreign currency |
| `GET` | `/account/{id}` | Get account using by id |
| `GET` | `/account/user` | Get all accounts using by user id via jwt token|
| `DELETE` | `/account/{id}` | Delete account using by account id |
| `PATCH` | `/account/{id}` | Add money to account using by account id |


#### Exchange

| Request Type | Path     | Description                |
| :-------- | :------- | :------------------------- |
| `GET` | `/exchange` | Get all exchanges using by user id via jwt token [History]|
| `POST` | `/exchange` | Make an exchange between two diferent account |
| `GET` | `/exchange/{id}` | Get exchange details using by id |
| `GET` | `/exchange/account/{id}` | Get all exchange details using by account id [History]|

#### Currency

<h6>All currency rates are up to date. // https://api.nbp.pl/</h6>

| Request Type | Path     | Description                |
| :-------- | :------- | :------------------------- |
| `GET` | `/currency/table` | Get all currency rates|
| `GET` | `/currency/table/period/{id}` | Get currency rates for 1 month |
| `GET` | `/currency/id/{id}` | Get currency using by id|

#### Launch the API on your device and navigate to the Swagger documentation endpoint to explore the available requests and responses.
http://localhost:8080/swagger-ui/index.html#/

<a name="screenshots-section"></a>
## Screenshots
### Login - Registration
<img src="https://github.com/user-attachments/assets/7c44ecb7-3b7f-4010-a826-1ee5d1988735" alt="drawing" width="200"/>
<img src="https://github.com/user-attachments/assets/f4bfc901-bde4-48f8-b98e-c34cd2fd5773" alt="drawing" width="200"/>

### Home
<img src="https://github.com/user-attachments/assets/832618e0-314d-44d3-8d24-9b372747fe2d" alt="drawing" width="200"/>
<img src="https://github.com/user-attachments/assets/9d1a189a-53c9-48e9-bb06-1fc0bcc628ba" alt="drawing" width="200"/>

### Account
<img src="https://github.com/user-attachments/assets/ef637cf8-c277-4689-8877-3aac6f3956bb" alt="drawing" width="200"/>
<img src="https://github.com/user-attachments/assets/4e478a1f-5eb0-4db1-ac1f-554353d1598c" alt="drawing" width="200"/>
<img src="https://github.com/user-attachments/assets/d07c235b-de0c-4556-b80f-38cb3cd1a8ea" alt="drawing" width="200"/>

### Exchange 
<img src="https://github.com/user-attachments/assets/1b160e1a-cc20-4916-ad55-0a08146a067e" alt="drawing" width="200"/>
<img src="https://github.com/user-attachments/assets/f174744e-57cb-4b40-a64a-4ec2c300ff8c" alt="drawing" width="200"/>
<img src="https://github.com/user-attachments/assets/007f5f36-a4ae-4516-823f-45325c31c7b1" alt="drawing" width="200"/>

### History
<img src="https://github.com/user-attachments/assets/d5b03c51-80a3-4a8f-897e-1a2273e6f4d8" alt="drawing" width="200"/>
<img src="https://github.com/user-attachments/assets/0a007454-81b6-4f6c-93f3-a9e7f7656f82" alt="drawing" width="200"/>
