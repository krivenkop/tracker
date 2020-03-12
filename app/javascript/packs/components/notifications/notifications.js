import React from 'react';

import Notification from './notification';

export default (props) => {
  const closeNotification = (slug) => {
    props.actions.setHiding(slug);
    setTimeout(
      () => { props.actions.removeNotification(slug); },
      1500,
    );
  };

  return (
    <div className="notifications">
      {props.notifications.map((el, index) => {
        return <Notification notification={el} key={index}
                             closeNotification={closeNotification}/>;
      })}
    </div>
  );
};
