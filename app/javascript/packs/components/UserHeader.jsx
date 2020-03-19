import React, { useState } from 'react';
import axios from 'axios';

export default (props) => {
  const [menuOpened, setMenuOpened] = useState(false);

  document.addEventListener('click', (e) => {
    if (!e.target.classList.contains('profile-header__open-mnu')) {
      setMenuOpened(false);
    }
  });

  const processLogoutClick = (e) => {
    e.preventDefault();
    try {
      axios.delete('/logout', { data: { refresh_token: props.refreshToken } })
        // eslint-disable-next-line promise/always-return
        .then(() => {
          props.destroyAuth();
        });
    } catch (err) {
      props.destroyAuth();
    }
  };

  return (
    <header className="header header--user header--mini">
      <div className="container-fluid h-100">
        <div className="row d-flex justify-content-end align-items-center h-100">
          <nav className="header__mnu mnu mnu--guest">
            <div className="header__profile profile-header">
              <button className="profile-header__open-mnu"
                      onClick={() => {
                        setMenuOpened(!menuOpened);
                      }}>
                {props.profile.email}
              </button>
              <ul className={`profile-header__mnu profile-mnu ${!menuOpened ? 'profile-mnu--hidden' : ''}`}>
                <a href="#" className="profile-mnu__item" onClick={(e) => processLogoutClick(e)}>
                  Logout
                </a>
              </ul>
            </div>
          </nav>
        </div>
      </div>
    </header>
  );
};
