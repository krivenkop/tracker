import React, { useState } from 'react';
import DoubleArrow from '@material-ui/icons/DoubleArrow';
import { Link } from 'react-router-dom';


export default (props) => {
  const toggleSidebarOpened = () => {
    props.setSidebarOpened(!props.sidebarOpened);
  };

  return (
    <aside className={`sidebar sidebar--user ${props.sidebarOpened ? 'sidebar--opened' : ''}`}>
      <Link to="/" className="sidebar__logo-link">
        <h1 className="sidebar__logo">Tracker</h1>
      </Link>
      <button className='sidebar__toggle-opened'
              onClick={toggleSidebarOpened}>
        <DoubleArrow fontSize="small" />
      </button>
    </aside>
  );
};
