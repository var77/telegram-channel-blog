import React, { Component } from 'react';
import { connect } from 'react-redux';
import { bindActionCreators } from 'redux';
import actionCreators from '../../actions/index';

import PostItem from '../../components/post';

import Enum from '../../enum';

import './index.css';
import '../../styles/index.css';

import Logo from '../../components/logo';

import AppBar from '@material-ui/core/AppBar';
import Toolbar from '@material-ui/core/Toolbar';
import Typography from '@material-ui/core/Typography';
import GridList from '@material-ui/core/GridList';


const { states } = Enum;

class App extends Component {
    async componentDidMount () {
        await this.props.getPosts()
    }


    render () {
        let { appState } = this.props;

        return (
            <div>
                <AppBar position="static" color="primary">
                    <Toolbar>
                        <Typography variant="title" color="inherit">
                            Telegram Channel Blog
                        </Typography>
                    </Toolbar>
                </AppBar>
                <div>
                    <div>
                        {appState === states.loading && <Logo loading />}
                    </div>
                    <div>
                        <GridList style={{display:'flex',justifyContent:'center'}} cols={3}>
                            {this.props.posts.map(post => <PostItem key={post.id} {...post}/>)}
                        </GridList>
                    </div>
                </div>
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



