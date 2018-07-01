import React, { Component } from 'react';

import '../../styles/index.css';
import './index.css';
import ReactLogo from './reactLogo';
import Fav from '../../assets/img/favicon.png'

export default class Logo extends Component {
    render () {
        let { loading } = this.props;
        return (
            <div style={{marginLeft:"50%",marginTop:"20%"}} alt="logo" className={`logo ${loading ? 'spin' : ''}`}>
                <ReactLogo />
            </div>
        );
    }
}
