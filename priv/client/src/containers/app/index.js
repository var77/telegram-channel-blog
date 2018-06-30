import React, { Component } from 'react';
import { connect } from 'react-redux';
import { bindActionCreators } from 'redux';
import actionCreators from '../../actions/index';

import PostItem from '../../components/post';

import Enum from '../../enum';

import './index.css';
import '../../styles/index.css';

import Logo from '../../components/logo';

const { states } = Enum;

class App extends Component {
    async componentDidMount () {
        await this.props.getPosts()
    }


    render () {
        let { appState } = this.props;
        
        return (
            <div className="flex flex-center flex-column flex1 width100">
                <h1>Telegram Channel Blog</h1>
                {appState === states.loading && <Logo loading />}
                {this.props.posts.map(post => <PostItem key={post.id} {...post}/>)}
            </div>
        );
    }
}

const mapStateToProps = state => ({
    appState: state.appState,
    posts: state.posts
});


const mapDispatchToProps = dispatch => bindActionCreators(actionCreators, dispatch);

export default connect(mapStateToProps, mapDispatchToProps)(App);

