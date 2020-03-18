import React from 'react';
import { Link } from 'react-router-dom';

export default () => (
    <header className="header">
      <div className="container h-100">
        <div className="row d-flex justify-content-between align-items-center h-100">
          <Link to="/" className="header__logo">
            Tracker
          </Link>
          <nav className="header__mnu mnu mnu--guest">
            <li className="mnu__item">
              <Link to="/" className="mnu__link">Login</Link>
            </li>
            <li className="mnu__item">
              <Link to="/register" className="mnu__link">Register</Link>
            </li>
          </nav>
        </div>
      </div>
    </header>
);
