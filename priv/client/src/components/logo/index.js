import React, { Component } from 'react';

import '../../styles/index.css';
import './index.css';
import ReactLogo from './reactLogo';

export default class Logo extends Component {
    render () {
        let { loading } = this.props;
        return (
            <div alt="logo" className={`logo ${loading ? 'spin' : ''}`}>
                <ReactLogo />
            </div>
        );
    }
}
