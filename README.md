# 💸 Exchange Bank App 💸

The Exchange Banking API is a feature-rich and real-time currency exchange platform. It enables users to create custom accounts, perform currency exchanges, and experience seamless banking operations powered by real-time data from the Narodowy Bank Polski API (NBP).

## Rest
https://github.com/CANWIA00/exchangeBankAPI

## API Reference
- Base url: http://localhost:8080/v1/
- All the endponints got secured with jwt token except Login and Register endpoints. So need to send also jwt token all the time via header.
- Launch the API on your device and navigate to the Swagger documentation endpoint to explore the available requests and responses.
http://localhost:8080/swagger-ui/index.html#/

#### Authentication Controller

| Request Type | Path     | Description                |
| :-------- | :------- | :------------------------- |
| `POST` | `/auth/register` | To register to app  |
| `POST` | `/exchange/login` | To login to app |

#### User Controller

| Request Type | Path     | Description                |
| :-------- | :------- | :------------------------- |
| `GET` | `/user` | Get user details  |

#### Account Controller

| Request Type | Path     | Description                |
| :-------- | :------- | :------------------------- |
| `POST` | `/acount/pln` | To create pln account when you register to app first |
| `POST` | `/account` | Create an account with foreign currency |
| `GET` | `/account/{id}` | Get account using by id |
| `GET` | `/account/user` | Get all accounts using by user id via jwt token|
| `DELETE` | `/account/{id}` | Delete account using by account id |
| `PATCH` | `/account/{id}` | Add money to account using by account id |


#### Exchange Controller

| Request Type | Path     | Description                |
| :-------- | :------- | :------------------------- |
| `GET` | `/exchange` | Get all exchanges using by user id via jwt token [History]|
| `POST` | `/exchange` | Make an exchange between two diferent account |
| `GET` | `/exchange/{id}` | Get exchange details using by id |
| `GET` | `/exchange/account/{id}` | Get all exchange details using by account id [History]|

#### Currency Controller

<h6>All currency rates are up to date. // https://api.nbp.pl/</h6>

| Request Type | Path     | Description                |
| :-------- | :------- | :------------------------- |
| `GET` | `/currency/table` | Get all currency rates|
| `GET` | `/currency/table/period/{id}` | Get currency rates for 1 month |
| `GET` | `/currency/id/{id}` | Get currency using by id|


## Screenshots
### Login - Registration
### Home
### Account
### History
