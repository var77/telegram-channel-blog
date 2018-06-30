import Enum from '../enum';
import Config from '../config';

const { types, states } = Enum;
const { api } = Config;

export const getPosts = (skip = 0, limit = 0, set = true) => {
    return async dispatch => {
        dispatch(changeState(states.loading));
        const res = await fetch(`${api.URL}/posts?skip=${skip}&limit=${limit}`);
        const posts = await res.json()
        dispatch(set ? setPosts(posts) : addPosts(posts));
        dispatch(changeState(states.loaded));
    }
}

export const getPost = (postId) => {
    return async dispatch => {
        dispatch(changeState(states.loading));
        const res = await fetch(`${api.URL}/post/${postId}`);
        dispatch(setPost(await res.json()));
        dispatch(changeState(states.loaded));
    }
}

export const changeState = state => ({
    state,
    type: types.changeState
});

export const addPosts = posts => ({
    posts,
    type: types.addPosts
});

export const setPost = post => ({
    post,
    type: types.setPost
})

export const setPosts = posts => ({
    posts,
    type: types.setPosts
})
