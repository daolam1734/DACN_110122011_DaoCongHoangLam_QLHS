import React, { useState } from 'react'
import { useNavigate } from 'react-router-dom'

export default function Dashboard() {
  const user = JSON.parse(localStorage.getItem('user') || '{}')
  const navigate = useNavigate()
  const [activeTab, setActiveTab] = useState('overview')

  const handleLogout = () => {
    localStorage.removeItem('token')
    localStorage.removeItem('user')
    navigate('/')
  }

  const tabs = [
    { id: 'overview', label: 'Tổng quan', icon: '📊' },
    { id: 'records', label: 'Hồ sơ đi nước ngoài', icon: '📁' },
    { id: 'reports', label: 'Báo cáo', icon: '📈' },
    { id: 'settings', label: 'Cài đặt', icon: '⚙️' },
  ]

  return (
    <div className="min-h-screen bg-gray-50">
      {/* Header */}
      <header className="bg-white shadow-sm border-b">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="flex justify-between items-center py-4">
            <div className="flex items-center">
              <h1 className="text-2xl font-bold text-gray-900">Hệ thống quản lý hồ sơ đi nước ngoài</h1>
            </div>
            <div className="flex items-center space-x-4">
              <span className="text-sm text-gray-700">Xin chào, <strong>{user.username || 'Người dùng'}</strong></span>
              <button
                onClick={handleLogout}
                className="bg-red-600 hover:bg-red-700 text-white px-4 py-2 rounded-md text-sm font-medium"
              >
                Đăng xuất
              </button>
            </div>
          </div>
        </div>
      </header>

      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <div className="flex">
          {/* Sidebar */}
          <div className="w-64 bg-white rounded-lg shadow-sm p-6 mr-8">
            <nav className="space-y-2">
              {tabs.map(tab => (
                <button
                  key={tab.id}
                  onClick={() => setActiveTab(tab.id)}
                  className={`w-full flex items-center px-4 py-2 text-sm font-medium rounded-md ${activeTab === tab.id
                      ? 'bg-indigo-100 text-indigo-700'
                      : 'text-gray-600 hover:bg-gray-50 hover:text-gray-900'
                    }`}
                >
                  <span className="mr-3">{tab.icon}</span>
                  {tab.label}
                </button>
              ))}
            </nav>
          </div>

          {/* Main Content */}
          <div className="flex-1">
            {activeTab === 'overview' && (
              <div className="space-y-6">
                <h2 className="text-2xl font-bold text-gray-900">Tổng quan</h2>
                <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
                  <div className="bg-white p-6 rounded-lg shadow-sm">
                    <div className="flex items-center">
                      <div className="p-2 bg-blue-500 rounded-md">
                        <span className="text-white text-xl">📁</span>
                      </div>
                      <div className="ml-4">
                        <p className="text-sm font-medium text-gray-600">Tổng hồ sơ</p>
                        <p className="text-2xl font-bold text-gray-900">0</p>
                      </div>
                    </div>
                  </div>
                  <div className="bg-white p-6 rounded-lg shadow-sm">
                    <div className="flex items-center">
                      <div className="p-2 bg-green-500 rounded-md">
                        <span className="text-white text-xl">✅</span>
                      </div>
                      <div className="ml-4">
                        <p className="text-sm font-medium text-gray-600">Đã duyệt</p>
                        <p className="text-2xl font-bold text-gray-900">0</p>
                      </div>
                    </div>
                  </div>
                  <div className="bg-white p-6 rounded-lg shadow-sm">
                    <div className="flex items-center">
                      <div className="p-2 bg-yellow-500 rounded-md">
                        <span className="text-white text-xl">⏳</span>
                      </div>
                      <div className="ml-4">
                        <p className="text-sm font-medium text-gray-600">Chờ duyệt</p>
                        <p className="text-2xl font-bold text-gray-900">0</p>
                      </div>
                    </div>
                  </div>
                </div>
                <div className="bg-white p-6 rounded-lg shadow-sm">
                  <h3 className="text-lg font-medium text-gray-900 mb-4">Hoạt động gần đây</h3>
                  <p className="text-gray-500">Chưa có hoạt động nào.</p>
                </div>
              </div>
            )}

            {activeTab === 'records' && (
              <div className="space-y-6">
                <div className="flex justify-between items-center">
                  <h2 className="text-2xl font-bold text-gray-900">Hồ sơ đi nước ngoài</h2>
                  <button className="bg-indigo-600 hover:bg-indigo-700 text-white px-4 py-2 rounded-md text-sm font-medium">
                    Thêm hồ sơ mới
                  </button>
                </div>
                <div className="bg-white p-6 rounded-lg shadow-sm">
                  <p className="text-gray-500">Chưa có hồ sơ nào. Nhấp vào "Thêm hồ sơ mới" để bắt đầu.</p>
                </div>
              </div>
            )}

            {activeTab === 'reports' && (
              <div className="space-y-6">
                <h2 className="text-2xl font-bold text-gray-900">Báo cáo</h2>
                <div className="bg-white p-6 rounded-lg shadow-sm">
                  <p className="text-gray-500">Tính năng báo cáo sẽ được phát triển.</p>
                </div>
              </div>
            )}

            {activeTab === 'settings' && (
              <div className="space-y-6">
                <h2 className="text-2xl font-bold text-gray-900">Cài đặt</h2>
                <div className="bg-white p-6 rounded-lg shadow-sm">
                  <p className="text-gray-500">Tính năng cài đặt sẽ được phát triển.</p>
                </div>
              </div>
            )}
          </div>
        </div>
      </div>
    </div>
  )
}
