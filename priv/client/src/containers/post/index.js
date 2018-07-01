import React, { Component } from 'react';
import { connect } from 'react-redux';
import { bindActionCreators } from 'redux';
import actionCreators from '../../actions/index';
import _ from 'underscore';
import { Link } from 'react-router';

import Enum from '../../enum';

import './index.css';

import Card from '@material-ui/core/Card';
import CardActions from '@material-ui/core/CardActions';
import CardContent from '@material-ui/core/CardContent';
import CardMedia from '@material-ui/core/CardMedia';
import Typography from '@material-ui/core/Typography';
import Button from '@material-ui/core/Button';



const { states } = Enum;

class Post extends Component {
    async componentDidMount () {

        const postId = this.props.params.id;
        if (!postId) return location.pathname = "/";

        const post = _.findWhere(this.props.posts, { id: postId });

        if (post) return this.props.setPost(post);

        this.props.getPost(postId);
    }


    render () {
        let { post } = this.props;

        return (
            <div className="cardSize">
                <Card>
                    {post.video && <video controls><source src={post.video}/></video>}
                    {post.photo && <CardMedia className="cardMedia" image={post.photo}/>}
                    <CardContent>
                        <Typography gutterBottom variant="headline" component="h2">
                            { post.title }
                        </Typography>
                        <Typography component="p">
                            { post.text }
                        </Typography>
                    </CardContent>
                    <CardActions>
                        <Button component={Link} to={`/`} size="small" color="primary">
                            Home
                        </Button>
                    </CardActions>
                </Card>
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
