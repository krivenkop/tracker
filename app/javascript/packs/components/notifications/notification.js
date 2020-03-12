import React, { useState } from 'react';

export default (props) => {
  return (
    <div className={`notifications__item notification 
           ${props.notification.hiding ? 'notification--hiding' : ''}`}
         key={props.index} onClick={() => {
           props.closeNotification(props.notification.slug);
         }
    }>
      {props.notification.title}
    </div>
  );
};
