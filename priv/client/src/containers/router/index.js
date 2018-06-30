import React, { Component } from 'react';
import { Router, Route, IndexRoute, hashHistory } from 'react-router'

import App from '../app'
import Post from '../post'

export default class AppRouter extends Component {

    render () {
        return (
            <Router history={hashHistory}>
                <Route path="/">
                    <IndexRoute component={App} />
                    <Route path="/post/:id" component={Post}/>
                </Route>
            </Router>
        );
    }
}