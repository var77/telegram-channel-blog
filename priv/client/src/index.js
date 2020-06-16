import React from 'react';
import ReactDOM from 'react-dom';
import Router from './containers/router/';
import { Provider } from 'react-redux';
import { createStore, applyMiddleware } from 'redux';
import reducers from './reducers';
import thunk from 'redux-thunk';

import './styles/index.css';

export const store = createStore(reducers, applyMiddleware(thunk));

ReactDOM.render(<Provider store={store} ><Router /></Provider>, document.getElementById('root'));
