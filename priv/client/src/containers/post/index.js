import React, { Component } from 'react';
import { connect } from 'react-redux';
import { bindActionCreators } from 'redux';
import actionCreators from '../../actions/index';
import _ from 'underscore';
import { Link } from 'react-router';

import Enum from '../../enum';

import './index.css';


const { states } = Enum;

class Post extends Component {
    async componentDidMount () {

        const postId = this.props.params.id
        if (!postId) return location.pathname = "/";

        const post = _.findWhere(this.props.posts, { id: postId });

        if (post) return this.props.setPost(post);

        this.props.getPost(postId);
    }


    render () {
        let { post } = this.props;
        
        return (
            <div className="flex flex-center flex-column flex1 post">
                <h1><Link to="/"> Home </Link></h1>
                <h2>{ post.title }</h2>
                <p>{ post.text }</p>
                {post.photo && <img src={post.photo} alt="" className="post-img"/>}
                {post.video && <video controls><source src={post.video}/></video>}
            </div>
        );
    }
}

const mapStateToProps = state => ({
    posts: state.posts,
    post: state.post
});


const mapDispatchToProps = dispatch => bindActionCreators(actionCreators, dispatch);

export default connect(mapStateToProps, mapDispatchToProps)(Post);

