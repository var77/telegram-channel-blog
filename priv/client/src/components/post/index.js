import React, { Component } from 'react';
import { Link } from 'react-router'

import '../../styles/index.css';
import './index.css';

import Card from '@material-ui/core/Card';
import CardActions from '@material-ui/core/CardActions';
import CardContent from '@material-ui/core/CardContent';
import CardMedia from '@material-ui/core/CardMedia';
import Typography from '@material-ui/core/Typography';
import Button from '@material-ui/core/Button';

export default class PostItem extends Component {
    render () {
        let CardWidth = Math.round(window.innerWidth/3.2);
        let { id, title, photo, text } = this.props;
        text = text.length > 20 ? text.slice(0, 20) + "..." : text;
        return (
            <div style={{width:CardWidth,margin:10}}>
                <Card>
                    {photo && <CardMedia className= "cardMedia" image={photo}/>}
                    <CardContent>
                        <Typography gutterBottom variant="headline" component="h2">
                            { title }
                        </Typography>
                        <Typography component="p">
                            { text }
                        </Typography>
                    </CardContent>
                    <CardActions>
                        <Button component={Link} to={`/post/${id}`} size="small" color="primary">
                            See post
                        </Button>
                    </CardActions>
                </Card>
            </div>
        );
    }
}
