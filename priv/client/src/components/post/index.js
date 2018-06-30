import React, { Component } from 'react';
import { Link } from 'react-router'

import '../../styles/index.css';
import './index.css';

import logoImg from '../../assets/img/react.svg';

export default class PostItem extends Component {
    render () {
        let { id, title, photo, text } = this.props;
        text = text.length > 20 ? text.slice(0, 20) + "..." : text;
        return (
            <Link to={`/post/${id}`} className="flex flex-center post-item" >
                {photo && <img src={photo} />}
                <div>
                    <h3> { title } </h3>
                    <p>{ text }</p>
                </div>
            </Link>
        );
    }
}
