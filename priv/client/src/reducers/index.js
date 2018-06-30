import { combineReducers } from 'redux';
import * as blogReducers from './blog.reducers';

export default combineReducers({ ...blogReducers });
