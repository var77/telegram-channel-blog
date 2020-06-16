import createReducer from '../helpers/createReducer';
import Enum from '../enum';

const { types, states } = Enum;

export const appState = createReducer(states.loading, {
    [types.changeState] (state, action) {
        return action.state;
    }
});

export const posts = createReducer([], {
    [types.addPosts] (state, action) {
        return [...state, ...action.posts];
    },
    [types.setPosts] (state, action) {
        return action.posts;
    }
});

export const post = createReducer([], {
    [types.setPost] (state, action) {
        return action.post;
    }
});