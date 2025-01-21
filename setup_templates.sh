#!/bin/bash

# Define the templates
TEMPLATES=(
  "dashboard"
  "auth"
  "websocket"
  "chatbot"
  "ml-dashboard"
  "mern"
  "graphql"
  "fastapi"
  "threejs"
)

GITHUB_USER="snooder"
GITHUB_REPO="msnyder-CRA-templates"

# Create monorepo structure
mkdir -p $GITHUB_REPO/packages
cd $GITHUB_REPO

echo "Initializing monorepo..."
npm init -y

# Install Lerna for versioning
echo "Installing Lerna..."
npm install --global lerna
npx lerna init

# Iterate over templates and create their structure
for TEMPLATE in "${TEMPLATES[@]}"; do
  TEMPLATE_DIR="packages/cra-template-msnyder-$TEMPLATE"
  echo "Creating template: $TEMPLATE_DIR"

  mkdir -p "$TEMPLATE_DIR/template/public"
  mkdir -p "$TEMPLATE_DIR/template/src/components"
  mkdir -p "$TEMPLATE_DIR/template/src/pages"

  # Create package.json with Vite and TypeScript support
  cat <<EOF > "$TEMPLATE_DIR/package.json"
{
  "name": "cra-template-msnyder-$TEMPLATE",
  "version": "1.0.0",
  "description": "msnyder $TEMPLATE template for Vite with TypeScript",
  "keywords": ["vite", "template", "react", "typescript", "$TEMPLATE"],
  "main": "template.json",
  "files": ["template", "template.json"],
  "repository": {
    "type": "git",
    "url": "https://github.com/$GITHUB_USER/$GITHUB_REPO.git"
  },
  "license": "MIT",
  "scripts": {
    "dev": "vite",
    "build": "vite build",
    "preview": "vite preview"
  },
  "publishConfig": {
    "access": "public"
  }
}
EOF

  # Define dependencies based on template type
  case $TEMPLATE in
    "dashboard")
      DEPS='"recharts": "^2.1.0", "@mui/material": "^5.3.0"'
      ;;
    "auth")
      DEPS='"firebase": "^9.6.0", "jsonwebtoken": "^9.0.0"'
      ;;
    "websocket")
      DEPS='"socket.io-client": "^4.5.0"'
      ;;
    "chatbot")
      DEPS='"openai": "^4.3.0"'
      ;;
    "ml-dashboard")
      DEPS='"tensorflow": "^2.9.0"'
      ;;
    "mern")
      DEPS='"mongoose": "^6.4.0", "express": "^4.18.0"'
      ;;
    "graphql")
      DEPS='"@apollo/client": "^3.6.0"'
      ;;
    "fastapi")
      DEPS='"fastapi": "^0.95.0"'
      ;;
    "threejs")
      DEPS='"three": "^0.141.0"'
      ;;
    *)
      DEPS=""
      ;;
  esac

  # Create template.json with TypeScript dependencies
  cat <<EOF > "$TEMPLATE_DIR/template/template.json"
{
  "package": {
    "dependencies": {
      "react": "^18.2.0",
      "react-dom": "^18.2.0",
      "react-router-dom": "^6.10.0",
      "react-icons": "^4.3.1",
      "tailwindcss": "^3.0.0",
      "typescript": "^4.8.4",
      "@types/react": "^18.0.20",
      "@types/react-dom": "^18.0.6",
      "postcss": "^8.4.14",
      "autoprefixer": "^10.4.7",
      $DEPS
    },
    "scripts": {
      "setup-tailwind": "npx tailwindcss init -p"
    }
  },
  "message": "Welcome to the msnyder-$TEMPLATE template! 🚀"
}
EOF

  # Create TypeScript config file
  cat <<EOF > "$TEMPLATE_DIR/template/tsconfig.json"
{
  "compilerOptions": {
    "target": "ESNext",
    "module": "ESNext",
    "jsx": "react-jsx",
    "strict": true,
    "moduleResolution": "node",
    "allowSyntheticDefaultImports": true,
    "skipLibCheck": true
  }
}
EOF

  # Create Tailwind config
  cat <<EOF > "$TEMPLATE_DIR/template/tailwind.config.js"
module.exports = {
  content: ["./src/**/*.{js,jsx,ts,tsx}"],
  theme: {
    extend: {
      spacing: {
        'vw-10': '10vw',
        'vw-20': '20vw',
        'vw-30': '30vw',
        'vw-40': '40vw'
      }
    }
  },
  plugins: [],
}
EOF

  # Create global CSS with Tailwind setup
  cat <<EOF > "$TEMPLATE_DIR/template/src/index.css"
@tailwind base;
@tailwind components;
@tailwind utilities;

body {
  @apply bg-gray-100 text-gray-900;
}
EOF

  # Create public/index.html
  cat <<EOF > "$TEMPLATE_DIR/template/public/index.html"
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>msnyder-$TEMPLATE Template</title>
</head>
<body>
    <div id="root"></div>
</body>
</html>
EOF

  # Create src/main.tsx
  cat <<EOF > "$TEMPLATE_DIR/template/src/main.tsx"
import React from "react";
import ReactDOM from "react-dom/client";
import "./index.css";
import App from "./App";

ReactDOM.createRoot(document.getElementById("root") as HTMLElement).render(
  <React.StrictMode>
    <App />
  </React.StrictMode>
);
EOF

  # Create src/App.tsx with routing
  cat <<EOF > "$TEMPLATE_DIR/template/src/App.tsx"
import React from "react";
import { BrowserRouter as Router, Routes, Route } from "react-router-dom";
import Navbar from "./components/Navbar";
import Home from "./pages/Home";
import Notifications from "./pages/Notifications";
import Profile from "./pages/Profile";
import Landing from "./pages/Landing";

function App() {
  return (
    <Router>
      <Navbar />
      <Routes>
        <Route path="/" element={<Landing />} />
        <Route path="/home" element={<Home />} />
        <Route path="/notifications" element={<Notifications />} />
        <Route path="/profile" element={<Profile />} />
      </Routes>
    </Router>
  );
}

export default App;
EOF


  # Create src/components/Navbar.tsx
  cat <<EOF > "$TEMPLATE_DIR/template/src/components/Navbar.tsx"
import React from "react";
import { Link } from "react-router-dom";
import { FaHome, FaBell, FaUser } from "react-icons/fa";

function Navbar() {
  return (
    <nav className="w-full flex justify-between items-center bg-blue-500 text-white p-[vw-4] shadow-md">
      <Link to="/" className="text-[vw-6] font-semibold">msnyder-$TEMPLATE</Link>
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
EOF

  # Create src/pages/Landing.tsx with navigation links
  cat <<EOF > "$TEMPLATE_DIR/template/src/pages/Landing.tsx"
import React from "react";
import { Link } from "react-router-dom";

function Landing() {
  return (
    <div className="p-[vw-6] text-center">
      <h1 className="text-[vw-7]">Welcome to msnyder-$TEMPLATE!</h1>
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
EOF

  # Create src/pages/Home.tsx
  cat <<EOF > "$TEMPLATE_DIR/template/src/pages/Home.tsx"
import React from "react";

function Home() {
  return (
    <div className="p-[vw-6] text-center">
      <h1 className="text-[vw-7]">Home Page</h1>
    </div>
  );
}

export default Home;
EOF

  # Create src/pages/Notifications.tsx
  cat <<EOF > "$TEMPLATE_DIR/template/src/pages/Notifications.tsx"
import React from "react";

function Notifications() {
  return (
    <div className="p-[vw-6] text-center">
      <h1 className="text-[vw-7]">Notifications Page</h1>
    </div>
  );
}

export default Notifications;
EOF

  # Create src/pages/Profile.tsx
  cat <<EOF > "$TEMPLATE_DIR/template/src/pages/Profile.tsx"
import React from "react";

function Profile() {
  return (
    <div className="p-[vw-6] text-center">
      <h1 className="text-[vw-7]">Profile Page</h1>
    </div>
  );
}

export default Profile;
EOF


done

echo "All templates have been created successfully!"
