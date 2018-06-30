import React, { Component } from 'react';

import '../../styles/index.css';
import './index.css';

import logoImg from '../../assets/img/react.svg';

export default class Logo extends Component {
    render () {
        let { loading } = this.props;

        return (
            <img src={logoImg} alt="logo" className={`logo ${loading ? 'spin' : ''}`} />
        );
    }
}
