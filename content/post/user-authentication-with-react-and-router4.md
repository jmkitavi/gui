+++
title = "User Authentication with React and Router4"
date = 2018-01-08T21:18:19+03:00
+++

This blog will build up from the previous blog about [simple routing](https://jmkitavi.github.io/gui/post/simple-routing-in-react/) in React. We will use the work done on that blog to build up on and add User Authentication to it. You can find the finished code from the previous blog [here](https://github.com/jmkitavi/simple-routing) (on my Github 🕶  ).

With the complete set up routes we can begin working on authentication. The method am going to elaborate here is protecting the routes and most of it will be done in the routes file. But to do this we will need the following:

- You (to do the work of course)
- Set up routes
- Authetication API
- Implementation (The fun part)

### Set Up Routes
As we already know, this blog will be using already set up routes, so we won't be going into much details about the routing. To go into the details on setting up the routes visit the blog on [simple routing](https://jmkitavi.github.io/gui/post/simple-routing-in-react/) or just grab the complete code from [here](https://github.com/jmkitavi/simple-routing).

To get started with this all you need to do is:

1. **Grab the code from Github.**
 - `git clone https://github.com/jmkitavi/simple-routing basic-auth`
 This will clone the `simple-routing` repo but rename it to `basic-auth`.

2. **Clean up Cloned code**
 - Delete github files. If you want to host your code in github you'll need to delete the github files cloned. Can be done by simply running `rm -rf .git` in the working directory.
 - In `package.json` edit the name from `simple-routing` to `basic-auth` or whatever 🤷 .

3. **Install pakcages**
 - Lastly install the packages needed. Simply `npm i`

With that done you should have a perfectly working Simple Routing application, then we are good to go. To check it run `npm start`.

### Authentication API
I had a hard time trying to choose an API from the countless availbale options, so I decided to use one of my own. I chose a  [bucketlist api](https://github.com/jmkitavi/bucketlist-api) I made a while back.

This was a favourable options since I got to play around with it as I played around with React. The API is in Python/Flask and implements user authentication using Json Web Tokens.

I have hosted the api on heroku at `http://kitavi-bucketlist.herokuapp.com`. You can go through the documentation in the [README](https://github.com/jmkitavi/bucketlist-api/blob/master/README.md).

As usual find all the code to the same on my [Github](https://github.com/jmkitavi/bucketlist-api). 


### Implementation
Let's get started with the fun part.

#### 1. Getting started

First off we will need bootstrap to style our forms and all that, so lets get it over with first.

Run command below to add bootstrap to your project,
```
npm i bootstrap
```
then, open `basic-auth/src/index.js` and add the bootstrap import so that it's available in the whole project.

``` js
import '../node_modules/bootstrap/dist/css/bootstrap.min.css';
```

Also we will need a simple Header to help with the Navigation.

Create `components/common/Header.js`
```
cd basic-auth/src/components
mkdir common
cd common
touch Header.js
```

add the following lines of code to display our Header
{{< gist jmkitavi 9f34dbdc88242af5aadee6b83a7efc7f >}}

Note: We have not set up the `/signup`, `/login` and `/logout` routes indicated in the header but we will be setting them up in a few.

To utilise the Header we just created, let's import it to the `App.js` file.
``` js
import Header from './common/Header'; 
```
Then add the component just above `{this.props.children}`
``` js
...
  <Header />
  {this.props.children}
...
```


#### 2. Sign Up Form
To get started on any authentication you need to have a sign up form to create users.

This is going to start out as a simple component and we will continue building up on it. In `basic-auth/src/components` let's add a directory to hold our user related components. Create the directory `components/user`.

> *It is a good practice to put related components in same directory.*

We will then go into the directory and add our `components/user/SignUp.js` file. 

Refer to the previous example on how to create the directory and file, or use other available options like your text editor.

Open up the `SignUp.js` file to get started with creating the Sign Up form.

We will forst have the basic display for the form, the we can work our way up from there on the functionality.

{{< gist jmkitavi f0c1bc83a225c221e842b656b8cbfa6c >}}

To display what we just created, we will have to add a route to the componet in our routes file. You first import the SignUp component to `routes.js`. The add it's route to the `Switch` component.

``` js
import SignUp from './components/user/SignUp';

...
  <Route exact path="/signup" component={SignUp} />

```

With that navigating to `http://localhost:3000/signup` should display our function less Sign Up Form 👏🏾 .


#### 3. Sign Up Functionality
To add functionality to our Sign Up form we'll first need to add two functions to the component.

1. **handleChange**
  - This will handle any change made in the input and save them to state

2. **handleSubmit**
  - This will handle submitting the request to the API

##### | handleChange
Like mentioned above, this is what will handle the `onChange` functionality for the forms. 

The handleChange is pretty simple, all you need to do is add the state for both the username and password that will be saved.

{{< gist jmkitavi c50d664d732b72a4d3ddf60f78e65fb1 >}}

  1️⃣ The constructor method is a special method for creating and initializing an object created with a class. It assigns the initial `this.state`

  2️⃣ Then we initialise `state`

  3️⃣ Then write `handleChange` functionality. Which is basically, get the `event` and update values to respective state.

  4️⃣ Ensure to `bind` the handleChange funtion.

  5️⃣ Then you have to use the function in the `onChange` event listener for both username and password fields.

##### | handleSubmit  (sign up)
After filling the required fields the user will require to submit the form so that the request is sent to the api for processing. This is where the `handleSubmit` function comes in. 

For the API interactions it's always advisable to have a file containing all functions that call the API. So we will create an `/src/api/` directory to hold all the files we will need for interactions with the API.

Then add `userApi.js` file, inside here we will write the function to interact with the API when user wants to sign up.

{{< gist jmkitavi c50e61ac9876a467db42dbbe5ba3cb4b >}}

- We are importing `axios` I library used to handle HTTP requests. So ensure to add it `npm i axios`
- The `signupUrl` is the url to which the sign up request will be posted.
- `signUpUser` function takes in username and password which are posted to API using `axios.post` method, receiving a response of successfull or failed user creation.

`handleSubmit` will take in the values saved to state by `handleChange` and send the request to the api.

{{< gist jmkitavi a1303c38050905250cf953e04805c791 >}}
- 
- 
- 

With this the user should be able to add a username and password and when successfull get redirected to the `/login` page where they can login in with the credentials they have given. **Note:** Since we do not have a LogIn page created yet it will display the 404 page.

With that we can now move on to the Login Page.

#### 4. Log In Form
This will be very much similar to the Sign Up Form since it providing username and password as is in the Sign Up Form, and then submitting it to the API.

{{< gist jmkitavi b08e2b2f7a4ff82e4a145bb60a090afa >}}

- I have included `handleChange` since it's the similar to the one in Sign Up.

As done earlier to be able to see this we will have to import the component to `routes.js` and add it's route to the `Switch` component.

```js
import LogIn from './components/user/LogIn';
...
  <Route exact path="/login" component={LogIn}>
```

Then navigate to `http://localhost:3000/login` to view the created Log In form. 

#### 5. Log In Functionality
Since we already worked on `handleChange` we are going to focus this to `handleSubmit` for Log In since it's the only major change between the Sign Up and Log In functionality.

##### | handleSubmit  (log in)
We will first go to the `userApi.js` file we created and add the code for handling login requests.

{{< gist jmkitavi 9b127222a04a66412bb9d504d3c1475f >}}

Now let's jump to the `LogIn.js` and add our `handleSubmit` and bind it to `onSubmit` for the Log in form.

{{< gist jmkitavi c1835d0eafd68cae1b4af8a3b7d2be1e >}}

- 
- 
- 

#### 6. Protected Routes
Authenticating users would not mean much if there isn't something being pretected. So let's implement Route Protection to prevent users that are not logged in from viewing certain routes.

This is best implemented when you have protected content that you only want logged in users to see. But since this is just a simple blog, we will not be creating any content.

What we will do to demonstrate protected routes:

- Make `/home` a protected route only visible to logged in users.
- Users that are not logged in will be redirected to `/login` when they try to access the protected route.

To get started we will need a function to check if the user is logged in or not. This function will check if user is logged in and return a boolean of either true or false.

Then, in Router 4, Protected Routes implementation are best done by building another component that wraps the `Route` component in itself. This is where we will call the function to check if user is logged in, then re and redirection if user is not logged in.

Let's write the code then.

{{< gist jmkitavi 384834b0c78a2643917c4703f9a95563 >}}

- 
- 
- 

Now lets edit our `/home` route to use the **PrivateRoute** we just created.

```js
  <PrivateRoute exact path="/home" component={HomePage} />
```

Now if a user that is not logged in tries to access the route `/home` they will get redirected to the `/login` route so they can first log in.

You might have a problem seeing that since most likely you had logged in, which brings us to the last part of any authentication process. Logging Out.

#### 7. Log Out
This should be the simplest component we work on.

As seen earlier we are saving the user token in local storage, which we also check to see if a user is logged in or not. So what we will do for log out is basically clear out the user token saved in local storage. This will log the user out and redirect them to the `/login` route.

{{< gist jmkitavi 29ca0f8e7012963f8a85492fa4137b33 >}}

- 
- 

Then we will finish by adding the component to the `routes.js` file.

``` js
import LogOut from './components/user/LogOut';
...
   <Route exact path="/logout" component={LogOut} />
```

And with that we have fully set up user authentication using React and Router 4. It definitely was long. It will help a lot if you take a few more peeps to the React and Router 4 documentations to help with understanding them more.

Thank You... Happy Learning!!

