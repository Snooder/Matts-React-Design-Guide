import React from "react";
import { Link } from "react-router-dom";

function Landing() {
  return (
    <div className="p-[vw-6] text-center">
      <h1 className="text-[vw-7]">Welcome to msnyder-fastapi!</h1>
      <div className="mt-[vw-5]">
        <Link to="/home" className="text-[vw-5] text-blue-500 hover:underline">Home</Link>
        <br />
        <Link to="/notifications" className="text-[vw-5] text-blue-500 hover:underline">Notifications</Link>
        <br />
        <Link to="/profile" className="text-[vw-5] text-blue-500 hover:underline">Profile</Link>
      </div>
    </div>
  );
}

export default Landing;
