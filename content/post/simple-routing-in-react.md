+++
title = "Simple Routing in React (Router4)"
date = 2017-11-27T20:38:51+03:00
+++

[React](https://reactjs.org/) is the most popular JavaScript front end framework. I recently (not really recently, been a while) started learning react. While learning it, React moved to a new implemntation of Router - `react-router v4`. I had already started learning the older one, but had to switch to learn the new one. It wasn't an easy ride, but using the [Router 4 docs](https://reacttraining.com/react-router) I managed to level up. Here is a short guide on **How To Do It**.

### Getting Started

If you are totally new in React, I'd advise you go through the basics of react like installation and setting up environments. [reactjs.org](https://reactjs.org/) will be very resourcefull, once you install react and set up you ready to start.

To get started run:
```sh
create-react-app app-name
```

Check out [Creating React App](https://reactjs.org/docs/installation.html#creating-a-new-application) for more details on the above command.

This will create a react application, with basic files needed. 

```
app-name
  ├── node_modules
  ├── public
  │   └── favicon.ico
  │   └── index.html
  │   └── manifest.json
  └── src
      └── App.css
      └── App.js
      └── App.test.js
      └── index.css
      └── index.js
      └── logo.svg
      └── registerServiceWorker.js
├── package.json
├── .gitignore
├── README.md
```

To run the app and see your progress.

Go into your project folder
```sh
cd app-name
```

Then run
```sh
npm start
```
or 
```sh
yarn start
```
Visit `http://localhost:3000/` to access the running application.


### Re-Structuring files

Now that we have this running lets re-structure our files. This helps a lot as your app keeps growing to have similar files put together.

We won't be doing any testing now so its safe to get rid of the test files. `*.test.js`.

Well start by adding a folder named `components` in the `app-name/src` folder.

You can create by running this in your working directory.
```sh
mkdir src/components
```

After creating the folder `app-name/src/components` move the file `App.js` to the folder.

Also create `styles` folder in `src`, this will contain the `*.css` files.

**Note:** *You will definitely have errors, we will take care of those soon.*

After creating the folders and moving the files stated above this should be your new folder structure:

```
app-name
  ├── node_modules
  ├── public
  │   └── favicon.ico
  │   └── index.html
  │   └── manifest.json
  └── src
  	  	├── components
        	└── App.js
        ├── styles
      		└── App.css
      		└── index.css
      └── index.js
      └── logo.svg
      └── registerServiceWorker.js
├── package.json
├── .gitignore
├── README.md
```

Due to the few files we moved, we expect to have a few import errors since they can't be found where they were.

Simple to fix, all we have to do is change the paths to reflect their new locations. lets do that.

- Delete `logo.svg` we won't be using it either, remove it's imports in `App.js`. Remember to delete the line of code that was using it too. `<img src={logo} ...`
- Update the css import in `App.js` to `import '../styles/App.css'` because of the new location of the css file
- Update the css import in `index.js` to `import './styles/index.css'`
- Also update import for `App.js` in `index.js` to `import App from './components/App'`

With those few fixes out app should be back to working condition.

Lets go to `http://localhost:3000/` to make sure of the same.

### Setting Up Routing
To set up routing lets first create a **HomePage** for our application.

Create a new folder in `components` named `home` and inside it a new file `HomePage.js`

```sh
mkdir home
cd home
touch HomePage.js
```
or use your favourite editor to create the folder and file inside the folder.

Also create a `routes.js` file in the `src` directory.

After creating this your files in `/src/` should look like below.
```
app-name
  └── src
  	  	├── components
        		├── home
                	└── HomePage.js
        	└── App.js
        ├── styles
      		└── App.css
      		└── index.css
      └── index.js
      └── registerServiceWorker.js
      └── routes.js
```

Now let's move all the code in `App.js` to `/home/HomePage.js` and edit it to look like this.

```js
import React, { Component } from 'react';
import '../../styles/App.css';


class HomePage extends Component{
  render() {
    return (
      <div className="App">
        <header className="App-header">
          <h1 className="App-title">Welcome to React</h1>
        </header>
        <p className="App-intro">
          To get started, edit <code>src/App.js</code> and save to reload.
        </p>
      </div>
    );
  }
}

export default HomePage;
```
Notice we change the class name to **HomePage** and exported it. Also we updated the css import since we moved one folder deeper than we previously were.

Next, we will convert our `App.js` to a parent component that will display children passed to it.

```js
import React, { Component } from 'react';
import PropTypes from 'prop-types';
import '../styles/App.css';

class App extends Component {
  render() {
    return (
      <div className="container-fluid">
        {this.props.children}
      </div>
    );
  }
}

App.PropTypes = {
  children: PropTypes.object.isRequired
};

export default App;
```
This is how our new `App.js` will look like.

This is important since we will have to pass it in our router file so that it can hold all the other components.

Lets jump onto the `routes.js` file and see that.

- So as usual for any React file we will import react. Then move on to importing what we need from `react-router`. Ensure you are using `router4`.
- Then we will import `App.js` like I mentioned earlier.
- Then import HomePage which we will use to test if our routing works.
- Lastly we will write the code to control the routing.

```js
import React from 'react';
import { Route, Switch } from 'react-router';
import App from './components/App';
import HomePage from './components/home/HomePage';

const Routes = () => (
  <App>
    <Switch>
      <Route exact path="/" component={HomePage} />
      <Route exact path="/home" component={HomePage} />
    </Switch>
  </App>
)
export default Routes;

```

Ensure to have `react-router` installed.
```sh
yarn add react-router
```

Be sure to check documentation for React Router 4 for what most of this is doing.

But in a nut shell after the imports we create a function `Routes` that takes in the `App` and `Switch` which basically switches between the different components you will have depending on the url.

I used both `/` and `/home` as the urls for our `HomePage` component.

Now that we have the routes file ready let's jump into the `index.js` (entry point of our application) and use the routes we just created.

The major difference here will be in the `render` function but first remember to import the following as we will need them. 
```js
import { BrowserRouter } from 'react-router-dom';
import Routes from './routes';
```
Ensure to have `react-router-dom` installed.
```sh
yarn add react-router-dom
```

Then update your render function to the following.
```js
render (
  <BrowserRouter>
    <Routes />
  </BrowserRouter>,
  document.getElementById('root')
);
```

This updates our application to start using the `Routes` we created, imported and passed in the `BrowserRouter` component.

With this done, our app should be running successfully and using our newly created Routes.

### Happy Coding.