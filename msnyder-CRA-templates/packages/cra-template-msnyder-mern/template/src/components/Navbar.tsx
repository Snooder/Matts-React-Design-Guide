import React from "react";
import { Link } from "react-router-dom";
import { FaHome, FaBell, FaUser } from "react-icons/fa";

function Navbar() {
  return (
    <nav className="w-full flex justify-between items-center bg-blue-500 text-white p-[vw-4] shadow-md">
      <Link to="/" className="text-[vw-6] font-semibold">msnyder-mern</Link>
      <div className="flex gap-[vw-3]">
        <Link to="/">
          <FaHome className="w-[vw-5] h-[vw-5] cursor-pointer hover:text-gray-300" />
        </Link>
        <Link to="/notifications">
          <FaBell className="w-[vw-5] h-[vw-5] cursor-pointer hover:text-gray-300" />
        </Link>
        <Link to="/profile">
          <FaUser className="w-[vw-5] h-[vw-5] cursor-pointer hover:text-gray-300" />
        </Link>
      </div>
    </nav>
  );
}

export default Navbar;
