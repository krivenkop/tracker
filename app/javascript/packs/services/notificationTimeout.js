import configureStore from '../store/configureStore';
import sluggify from './sluggify';
import { setHiding } from '../actions/notifications';

export default (title) => {
  const slug = sluggify(title);

  console.log('timeout before: ' + slug);

  setTimeout(() => {
    console.log('in timeout: ' + slug, configureStore().dispatch, setHiding(slug));
    configureStore().dispatch(setHiding(slug));
  }, 2000);

  return slug;
};
