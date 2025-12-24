import React from 'react';
import Header from './Header';
import Sidebar from './Sidebar';

export default function MainLayout({ children }) {
  return (
    <div className="min-h-screen bg-gray-50">
      <Header />
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <div className="flex">
          <Sidebar />
          <div className="flex-1 ml-8">
            {children}
          </div>
        </div>
      </div>
    </div>
  );
}