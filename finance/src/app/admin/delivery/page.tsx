'use client';

import React, { useState, useMemo,useRef,useEffect } from 'react';
import { Table, Button, Space, Input, DatePicker, Drawer, Form ,Select,Tag,Modal,Checkbox,message,InputNumber,List,Row,Col,Tooltip} from 'antd';
import type { ColumnsType } from 'antd/es/table';
import { EditOutlined, DeleteOutlined,PlusOutlined, EyeOutlined} from '@ant-design/icons';
import dayjs, { Dayjs } from 'dayjs';
import isSameOrAfter from 'dayjs/plugin/isSameOrAfter';
import isSameOrBefore from 'dayjs/plugin/isSameOrBefore';
import * as XLSX from 'xlsx';
const { Option } = Select;


const { RangePicker } = DatePicker;
dayjs.extend(isSameOrAfter);
dayjs.extend(isSameOrBefore);

interface Good {
  name: string;
}

interface Item {
  id: number;
  good_id: number;
  quantity: number;
  good?: Good;   // add this property to match backend data
  // add other fields if needed
}

interface Delivery {
  id: number;
  phone: string;
  address: string;
  status: number | string;
  price: number;
  comment: string;
  driver_comment?: string; // Add this if it exists
  driver: {
    username: string;
  };
  createdAt: string;
  merchant: {
    username: string;
  };
  status_name: {
    status: string;
    color: string;
  };
  postponed_number?: number; // Add this line
  items?: Item[];
  image?: string; // ✅ Add this line - make it optional
}
const products = [
  { id: 'p1', name: 'Бараа 1', price: 1000 },
  { id: 'p2', name: 'Бараа 2', price: 1500 },
  { id: 'p3', name: 'Бараа 3', price: 2000 },
];

interface DeliveryStatus {
  id: number;
  status: string;
  color: string;
  createdAt?: string;
  updatedAt?: string;
}

interface ProductItem {
  productId: string;
  productName: string;
  quantity: number;
  price: number; // нэмэгдсэн
}



export default function DeliveryPage() {

  const [selectedRowKeys, setSelectedRowKeys] = useState<React.Key[]>([]);
  const [merchantFilter, setMerchantFilter] = useState<number | null>(null);
  const [dateRange, setDateRange] = useState<[Dayjs | null, Dayjs | null]>([null, null]);
  const [isModalVisible, setIsModalVisible] = useState(false);
  const [isStatusModal, setIsStatusModal] = useState(false);
const [isImageModalVisible, setIsImageModalVisible] = useState(false);
const [selectedImageUrl, setSelectedImageUrl] = useState<string | null>(null);
  const [form] = Form.useForm();
  const [isDrawerVisible, setIsDrawerVisible] = useState(false);
  const [merchants, setMerchants] = useState<{ id: number; username: string }[]>([]);
  const [deliveryData, setDeliveryData] = useState<Delivery[]>([]);
  const [drivers, setDrivers] = useState<{ id: number; username: string }[]>([]);
  const [selectedDriverId, setSelectedDriverId] = useState<number | null>(null);
  const [pagination, setPagination] = useState({ current: 1, pageSize: 50, total: 0 });
  const [pullFromWarehouse, setPullFromWarehouse] = useState(false);
  const [productList, setProductList] = useState<ProductItem[]>([]);
  const [selectedProduct, setSelectedProduct] = useState(null);
  const [quantity, setQuantity] = useState(1);
  const [productPrice, setProductPrice] = React.useState<number>(0);
  const [status, setStatus] = useState<{ id: number; status: string }[]>([]);
  const [loading, setLoading] = useState(false);
  const [selectedDriver, setSelectedDriver] = useState(null);
  const [fetched, setFetched] = useState(false); // prevent re-fetch
  const [driverFilter, setDriverFilter] = useState<number | null>(null);

const [deliveryDate, setDeliveryDate] = useState<Dayjs | null>(dayjs()); // Default to today
  const [selectStatusId, setSelectedStatusId] = useState<number | null>(null);

  const fileInputRef = useRef<HTMLInputElement | null>(null);
  const [products, setProducts] = useState<{ id: string; name: string }[]>([]);
  const [permissions, setPermissions] = useState<string[]>([]);
  const [refreshKey, setRefreshKey] = useState(0);

  const userData = typeof window !== 'undefined' ? localStorage.getItem('user') : null;
  const user = userData ? JSON.parse(userData) : null;
  const isMerchant = user?.role === 2;
  const username = typeof window !== 'undefined' ? localStorage.getItem('username') : null;
  const [isEditModal, setIsEditModal] = useState(false);
  const [merchs, setMerchs] = useState<{ id: number; username: string }[]>([]);

  const merchantId = isMerchant ? user.id : null;
  const [statusList, setStatusList] = useState<DeliveryStatus[]>([]);
  const [selectedStatuses, setSelectedStatuses] = useState<number[]>([]);
  const [selectedMerchantId, setSelectedMerchantId] = useState(merchantId || '');
  const [selectedDelivery, setSelectedDelivery] = useState<Delivery | null>(null);

  const [expandedRowKeys, setExpandedRowKeys] = React.useState<React.Key[]>([]);
  const [expandedItems, setExpandedItems] = React.useState<Record<number, Item[] | null>>({});
  const [loadingRows, setLoadingRows] = React.useState<number[]>([]);

  const handleEditClick = (record: Delivery) => {
  setSelectedDelivery(record);
  form.setFieldsValue({
    phone: record.phone,
    address: record.address,
    price: record.price, // Add this line
  });
  setIsEditModal(true);
};
   const handleMerchantFilterChange = (value: number | null) => {
    setMerchantFilter(value);
    setPagination((prev) => ({ ...prev, current: 1 }));
  };
const fetchMerchant = async () => {
  if (fetched) return; // only fetch once
  setLoading(true);
  try {
    const response = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/user/merchant`);
    const result = await response.json();
    if (result.success) {
const activeMerchants = (result.data as any[]).filter((m: any) => m.status === 2);
      setMerchs(activeMerchants);
      setFetched(true);
    }
  } catch (error) {
    console.error('Failed to fetch merchants:', error);
  } finally {
    setLoading(false);
  }
};

const handleViewImage = (imageUrl: string) => {
  setSelectedImageUrl(imageUrl);
  setIsImageModalVisible(true);
};

const handleCloseImageModal = () => {
  setIsImageModalVisible(false);
  setSelectedImageUrl(null);
};
  
  const baseColumns: ColumnsType<Delivery> = [
    {
      title: 'Үүссэн огноо',
      dataIndex: 'createdAt',
      render: (text: string) => {
        return dayjs(text).format('YYYY-MM-DD hh:mm A'); // Format the date here
      },
    },
 {
      title: 'Хүргэсэн огноо',
      dataIndex: 'delivered_at',
      render: (text: string) => {
        return dayjs(text).format('YYYY-MM-DD hh:mm A'); // Format the date here
      },
    },
    { 
      title: 'Мерчант нэр', 
      key:'merchant',
      dataIndex: ['merchant', 'username'], 
      render: (_, record) => record.merchant?.username || '-' 
    },
  {
    title: 'Хаяг / Утас',
    key: 'contact',
    render: (_: any, record: Delivery) => (
      <div>
        <div><strong>{record.phone}</strong></div>
        <div>{record.address}</div>
      </div>
    ),
  },
  
    // Updated Status Column with Tag
   // Updated Status Column with Tag and Tooltip
{
  title: 'Төлөв',
  dataIndex: 'status_name',
  render: (status_name: { status: string, color: string }, record: Delivery) => {
    // Check if status is 10 (хойшлуулсан)
    const isPostponed = record.status === 10 || record.status === '10';
    const postponedNumber = record.postponed_number || 0;
    
    return (
      <Tooltip 
        title={isPostponed && postponedNumber > 0 ? `Хойшлуулсан ${postponedNumber} удаа` : null}
        placement="top"
      >
        <Tag color={status_name.color}>
          {status_name.status}
          {isPostponed && postponedNumber > 0 && (
            <span style={{ marginLeft: 4, fontWeight: 'bold' }}>
              ({postponedNumber})
            </span>
          )}
        </Tag>
      </Tooltip>
    );
  },
},
    
    { title: 'Үнэ', dataIndex: 'price' },
    { title: 'Тайлбар', dataIndex: 'comment' },
    { title: 'Ж/тайлбар', dataIndex: 'driver_comment' },

    {
  title: 'Жолооч нэр', 
  key: 'driver',
  dataIndex: ['driver', 'username'], 
  render: (_, record) => record.driver?.username || '-' 
},
{
  title: 'Үйлдэл',
  key: 'actions',
  render: (_: any, record: Delivery) => (
    <Space>
      <Button
        type="link"
        icon={<EditOutlined />}
        onClick={() => handleEditClick(record)}
      >
        Edit
      </Button>
      {record.image && (
        <Button
          type="link"
          icon={<EyeOutlined />}
          onClick={() => handleViewImage(record.image!)}
          style={{ color: '#1890ff' }}
        >
          Зураг харах
        </Button>
      )}
    </Space>
  ),
}
  ];
  
  const columns: ColumnsType<Delivery> = isMerchant
    ? baseColumns.filter(col => col.key !== 'merchant' && col.key !== 'actions' && col.key !== 'driver') as ColumnsType<Delivery>
    : baseColumns;
  const [phoneFilter, setPhoneFilter] = useState('');

  React.useEffect(() => {
    
    if (pullFromWarehouse) {
      if (!selectedMerchantId) {
        message.warning('Дэлгүүрийг эхлээд сонгоно уу!');
        setPullFromWarehouse(false); // uncheck checkbox automatically
        return;
      }
      // fetch products
      (async () => {
        try {
          const res = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/good?merchant_id=${selectedMerchantId}`);
          const json = await res.json();
  
          if (json.success) {
            const apiProducts = json.data.map((item: any) => ({
              id: item.id.toString(),
              name: item.name,
            }));
            setProducts(apiProducts);
          } else {
            message.error('Барааг ачааллахад алдаа гарлаа');
            setProducts([]);
          }
        } catch (error) {
          message.error('Сүлжээний алдаа');
          setProducts([]);
        }
      })();
    } else {
      // If checkbox unchecked, clear products & product list
      setProducts([]);
      setProductList([]);
    }
  }, [pullFromWarehouse, merchantId]);
  
  // Merchant Select onChange
  // const handleMerchantChange = (value: number) => {
  //   setMerchantId(value);
  //   // Reset products & selections when merchant changes
  //   setProducts([]);
  //   setSelectedProduct(null);
  //   setProductList([]);
  // };
  
const handleEdit = async () => {
  try {
    const values = await form.validateFields();

    const updateData = {
      phone: values.phone,
      address: values.address,
      price: values.price || 0, // Add this line
    };

    const response = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/delivery/${selectedDelivery?.id}`, {
      method: 'PUT',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(updateData),
    });

    const result = await response.json();

    if (response.ok && result.success) {
      console.log('Updated successfully:', result.data);
      setIsEditModal(false);
      // Refresh the delivery data to show updated values
      setRefreshKey(prev => prev + 1);
    } else {
      console.error('Failed to update delivery:', result.message);
    }

  } catch (err) {
    console.error('Validation or request failed:', err);
  }
};
const handleDriverFilterChange = (value: number | null) => {
  setDriverFilter(value);
  setPagination((prev) => ({ ...prev, current: 1 }));
};

const fetchDrivers = async () => {
  if (fetched) return; // only fetch once
  setLoading(true);
  try {
    const response = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/user/driver`);
    const result = await response.json();
    if (result.success) {
      setDrivers(result.data);
      setFetched(true);
    }
  } catch (error) {
    console.error('Failed to fetch drivers:', error);
  } finally {
    setLoading(false);
  }
};


  useEffect(() => {
    form.setFieldsValue({ merchantId: selectedMerchantId });

    const fetchAllData = async () => {
      try {
        document.title = 'Хүргэлт';
  
        // Init user & permissions
        const storedUser = window.localStorage.getItem('user');
        const storedPermissions = window.localStorage.getItem('permissions');
  
        if (storedPermissions) setPermissions(JSON.parse(storedPermissions));
        const parsedUser = storedUser ? JSON.parse(storedUser) : null;
  
        const userIsMerchant = parsedUser?.role === 2;
        const merchantId = userIsMerchant ? parsedUser.id : null;
  
        if (userIsMerchant) {
          form.setFieldsValue({ merchantId });
        }
  
        // Fetch merchants only once
        if (merchants.length === 0) {
  const merchantRes = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/user/merchant`);
  const merchantsResult = await merchantRes.json();

  if (merchantsResult.success) {
    const filteredMerchants = (merchantsResult.data as any[]).filter(
      (m: any) => m.status === 2
    );
    setMerchants(filteredMerchants);
  }
}

  
        // Fetch statuses only once
        if (statusList.length === 0) {
          const statusRes = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/status`);
          const statusResult = await statusRes.json();
          if (statusResult.success) setStatusList(statusResult.data);
        }
  
        // Build delivery URL with filters
        let url = `${process.env.NEXT_PUBLIC_API_URL}/api/delivery?page=${pagination.current}&limit=${pagination.pageSize}`;
  
        if (userIsMerchant) {
          url += `&merchant_id=${merchantId}`;
        } else if (merchantFilter) {
          url += `&merchant=${merchantFilter}`;
        }

 	if (merchantFilter) {
          url += `&merchant_id=${merchantFilter}`;
        }


        if(phoneFilter) {
          url += `&phone=${phoneFilter}`;
        }

        if (driverFilter) {
          url += `&driver_id=${driverFilter}`;
        }
  
        if (selectedStatuses.length > 0) {
          url += `&status_ids=${selectedStatuses.join(',')}`;
        }
  
        if (dateRange[0] && dateRange[1]) {
          url += `&start_date=${dateRange[0]?.format('YYYY-MM-DD')}`;
          url += `&end_date=${dateRange[1]?.format('YYYY-MM-DD')}`;
        }
  
        const deliveryRes = await fetch(url);
        const deliveryResult = await deliveryRes.json();
        if (deliveryResult.success) {
          setDeliveryData(deliveryResult.data);
          setPagination((prev) => ({ ...prev, total: deliveryResult.pagination.total }));
        }
  
      } catch (err) {
        console.error('Error initializing or fetching data:', err);
      }
    };
  
    fetchAllData();
  }, [pagination.current, pagination.pageSize, merchantFilter, selectedStatuses,driverFilter, phoneFilter,dateRange,selectedMerchantId,refreshKey]);
  
  
  const rowSelection = {
    selectedRowKeys,
    onChange: (selectedKeys: React.Key[]) => {
      setSelectedRowKeys(selectedKeys);
    },
  };

  const handleDeliveryButton = () => {
    setIsDrawerVisible(true);
  };

  // Handle modal cancel
  const handleDelete = async () => {
    // Шалгах: бүх сонгогдсон item-уудын статус 1 эсэх
    const selectedDeliveries = deliveryData.filter(item => selectedRowKeys.includes(item.id));
    const nonDeletable = selectedDeliveries.filter(item => item.status !== 1);
  
    if (nonDeletable.length > 0) {
      message.warning("Устгах боломжгүй хүргэлт байна.");
      return;
    }
  
    Modal.confirm({
      title: `Та ${selectedRowKeys.length} ширхэг хүргэлтийг устгахдаа итгэлтэй байна уу?`,
      okText: "Тийм",
      cancelText: "Үгүй",
      onOk: async () => {
        try {
          const response = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/delivery/delete-multiple`, {
            method: "POST",
            headers: {
              "Content-Type": "application/json",
            },
            body: JSON.stringify({ ids: selectedRowKeys }),
          });
  
          if (!response.ok) throw new Error("Амжилтгүй боллоо");
  
          message.success("Амжилттай устгагдлаа");
  
          const refreshed = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/delivery`);
          const refreshedResult = await refreshed.json();
          if (refreshedResult.success) {
            setDeliveryData(refreshedResult.data);
          }
  
          form.resetFields();
          setIsDrawerVisible(false);
          setSelectedRowKeys([]);
        }  catch (error) {
          const err = error as Error;
          message.error("Алдаа гарлаа: " + err.message);
        }
      },
    });
  };
  
  const handleCheckboxChange = () => {
    setPullFromWarehouse(prev => !prev);

  };
  
const handleAddProduct = () => {
  if (!selectedProduct || quantity < 1) {
    message.warning('Бараа болон тоо оруулна уу');
    return;
  }

  const productObj = products.find(p => p.id === selectedProduct);

  if (productObj) {
    setProductList(prev => {
      // Add new item with current productPrice (from input)
      const newList = [
        ...prev,
        {
          productId: productObj.id,
          productName: productObj.name,
          quantity,
          price: productPrice || 0, // Default to 0 if empty
        }
      ];

      // Calculate total sum using each item's own price
      const totalSum = newList.reduce((acc, item) => acc + item.price * item.quantity, 0);

      // Update form price field only if there's a value
      form.setFieldsValue({ price: totalSum > 0 ? totalSum : undefined });

      return newList;
    });
  } else {
    message.error("Сонгосон бараа олдсонгүй!");
  }

  setSelectedProduct(null);
  setQuantity(1);
  setProductPrice(0); // reset price input if needed
};

  const handleCancel = () => {
    setIsEditModal(false);
  };

  // Handle form submission (for example, you could save data here)
const handleOk = async () => {
  try {
    const values = await form.validateFields();

    // ✅ Get token (adjust if using cookies or session)
    const token = localStorage.getItem('token');
    if (!token) {
      message.error('Токен олдсонгүй. Та дахин нэвтэрнэ үү.');
      return;
    }

    // ✅ Handle null/undefined price
    const price = values.price ? Number(values.price) : 0;

    // ✅ Construct payload
    const payload = {
      merchant_id: isMerchant ? user.id : values.merchantId,
      phone: values.phone,
      address: values.address,
      status: 1,
      price: price,
      comment: values.comment || '',
      items: productList.map(item => ({
        good_id: item.productId,
        quantity: item.quantity,
      })),
    };

    // ✅ Send POST request with token
    const response = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/delivery`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        Authorization: `Bearer ${token}`, // ✅ Attach token
      },
      body: JSON.stringify(payload),
    });

    const result = await response.json();

    if (result.success) {
      message.success('Амжилттай бүртгэгдлээ');
      setRefreshKey(prev => prev + 1);
      form.resetFields();
      setProductList([]);
      setSelectedProduct(null);
      setQuantity(1);
      setProductPrice(0);
      setIsDrawerVisible(false);
    } else {
      message.error('Хадгалахад алдаа гарлаа: ' + (result.message || 'Тодорхойгүй алдаа'));
    }
  } catch (err) {
    console.error('Validation or request error:', err);
    message.error('Формыг шалгана уу.');
  }
};


  const handleDeleteProduct = (productId: string) => {
    setProductList(prev => {
      const newList = prev.filter(item => item.productId !== productId);
  
      // Recalculate total sum after deletion
      const totalSum = newList.reduce((acc, item) => acc + item.price * item.quantity, 0);
  
      // Update form price field accordingly
      form.setFieldsValue({ price: totalSum > 0 ? totalSum : undefined });
  
      return newList;
    });
  };
  
  const toggleStatus = (id: number) => {
    setSelectedStatuses((prev) =>
      prev.includes(id) ? prev.filter((statusId) => statusId !== id) : [...prev, id]
    );
  };

  
// Inside your component:
const processExcelFile = async (file: File) => {
  const reader = new FileReader();
  reader.onload = async (e) => {
    const data = new Uint8Array(e.target?.result as ArrayBuffer);
    const workbook = XLSX.read(data, { type: 'array' });
    const sheet = workbook.Sheets[workbook.SheetNames[0]];
    const json = XLSX.utils.sheet_to_json(sheet, { header: 1 });

    const rows = json.slice(1); // Skip header row
    const formatted = rows.map((row: any) => ({
      merchantName: row[0],
      phone: row[1],
      address: row[2],
      price: row[3],
      comment: row[4],
    }));

    console.log('Parsed Excel:', formatted);

    const response = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/delivery/import`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ deliveries: formatted }),
    });

    const result = await response.json();
    if (result.success) {
      alert(`${result.inserted || formatted.length} deliveries imported successfully.`);
      const refreshed = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/delivery`);
      const refreshedResult = await refreshed.json();
      if (refreshedResult.success) setDeliveryData(refreshedResult.data);
    } else {
      alert('Import failed');
    }
  };
  reader.readAsArrayBuffer(file);
};

const handleDrop = (e: React.DragEvent<HTMLDivElement>) => {
  e.preventDefault();
  const file = e.dataTransfer.files[0];
  if (file && file.name.endsWith('.xlsx')) {
    processExcelFile(file);
  }
};



  async function fetchItemsForDelivery(deliveryId: number): Promise<Item[]> {
    try {
      const response = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/delivery/${deliveryId}/items`);
      if (!response.ok) {
        throw new Error(`Error fetching items: ${response.statusText}`);
      }
      const data = await response.json();
  
      // Assuming your API response format: { success: true, data: [...] }
      if (data.success && Array.isArray(data.data)) {
        return data.data;
      } else {
        throw new Error('Invalid data format received');
      }
    } catch (error) {
      console.error(error);
      return []; // Return empty array on error to avoid breaking UI
    }
  }
  

  const handleExpand = async (expanded: boolean, record: Delivery) => {
    if (expanded) {
      setExpandedRowKeys([record.id]); // allow only 1 expanded row
  
      // If items not already loaded, fetch them
      if (!expandedItems[record.id]) {
        setLoadingRows((prev) => [...prev, record.id]);
        const items = await fetchItemsForDelivery(record.id);
        setExpandedItems((prev) => ({ ...prev, [record.id]: items }));
        setLoadingRows((prev) => prev.filter((id) => id !== record.id));
      }
    } else {
      setExpandedRowKeys([]);
    }
  };


const handleExcelImport = (e: React.ChangeEvent<HTMLInputElement>) => {
  const file = e.target.files?.[0];
  if (file && file.name.endsWith('.xlsx')) {
    processExcelFile(file);
  }
};

  const handleCloseDrawer = () => {
    setIsDrawerVisible(false);
  };
  
  
  const handleStatus = async () => {
    if (selectedRowKeys.length === 0) {
      alert('Please select at least one delivery.');
      return;
    }

    // Fetch drivers only when this function is called
    try {
      const response = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/status`);
      const result = await response.json();
      
      if (result.success) {
        setStatus(result.data); // Set the list of drivers
        setIsStatusModal(true); // Open the modal
      } else {
        alert('Failed to load drivers.');
      }
    } catch (error) {
      console.error('Error fetching drivers:', error);
      alert('Error fetching drivers.');
    }
  };

  const handleAllocateToDriver = async () => {
    if (selectedRowKeys.length === 0) {
      alert('Please select at least one delivery.');
      return;
    }

    // Fetch drivers only when this function is called
    try {
      const response = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/user/driver`);
      const result = await response.json();
      
      if (result.success) {
        setDrivers(result.data); // Set the list of drivers
        setIsModalVisible(true); // Open the modal
      } else {
        alert('Failed to load drivers.');
      }
    } catch (error) {
      console.error('Error fetching drivers:', error);
      alert('Error fetching drivers.');
    }
  };

  const handleDriverSelection = (value: number) => {
    setSelectedDriverId(value); // Set the selected driver ID
  };

  const handleStatusSelection = (value: number) => {
    setSelectedStatusId(value); // Set the selected driver ID
  };
  const hasPermission = (perm: string) => permissions.includes(perm);

  const handleSaveAllocation = async () => {
  if (!selectedDriverId) {
    message.error('Please select a driver!');
    return;
  }

 

  try {
    const response = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/delivery/allocate`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        driver_id: selectedDriverId,
        delivery_ids: selectedRowKeys,
      }),
    });

    const result = await response.json();

    if (result.success) {
      // Close the modal and reset the state
      setIsModalVisible(false);
      setSelectedDriverId(null);
      setDeliveryDate(dayjs()); // Reset to today for next time
      message.success('Deliveries allocated to the driver successfully.');

      // Clear selected rows and refresh data
      setSelectedRowKeys([]);
      setRefreshKey(prev => prev + 1);
    } else {
      message.error('Failed to allocate deliveries: ' + (result.message || 'Unknown error'));
    }
  } catch (error) {
    console.error('Error allocating deliveries:', error);
    message.error('Error allocating deliveries');
  }
};

const handeStatusChange = async () => {
  if (!selectStatusId) {
    alert('Please select a status!');
    return;
  }

  try {
    const response = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/delivery/status`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        status_id: selectStatusId,
        delivery_ids: selectedRowKeys,
      }),
    });

    const result = await response.json();

    if (result.success) {
      // Close the modal and reset the state
      setIsStatusModal(false);
      setSelectedStatusId(null);
      message.success('Deliveries status changed successfully.');
      
      // Clear selected rows
      setSelectedRowKeys([]);
      
      // Refresh data with current filters by incrementing refreshKey
      setRefreshKey(prev => prev + 1);
    } else {
      message.error('Failed to change status: ' + (result.message || 'Unknown error'));
    }
  } catch (error) {
    console.error('Error changing status:', error);
    message.error('Error changing status');
  }
};
  
  return (
    <div style={{ paddingBottom: '100px' }}> {/* Adding padding to prevent overlap with fixed button */}
      <h1 style={{ marginBottom: 24 }}>Хүргэлт</h1>

 <Space
  style={{ marginBottom: 16, width: '100%', flexWrap: 'wrap' }}
  size={[12, 12]}
  direction="horizontal"
  wrap
>
  {/* Phone filter */}
  <Input
    placeholder="📞 Утас"
    value={phoneFilter}
    onChange={(e) => setPhoneFilter(e.target.value)}
    allowClear
    style={{ width: 200 }}
  />

  {/* Date range filter */}
  <RangePicker
    value={dateRange}
    onChange={(range) => setDateRange(range ?? [null, null])}
    style={{ width: 260 }}
  />

  {/* Status tags */}
  <div style={{ display: 'flex', gap: 8, flexWrap: 'wrap' }}>
    {statusList.map((status) => (
      <Tag
        key={status.id}
        color={status.color || 'default'}
        onClick={() => toggleStatus(status.id)}
        style={{
          cursor: 'pointer',
          userSelect: 'none',
          padding: '5px 12px',
          fontSize: 13,
          borderRadius: 6,
          border: selectedStatuses.includes(status.id)
            ? '2px solid #52c41a'
            : '1px solid #d9d9d9',
        }}
      >
        {status.status}
      </Tag>
    ))}
  </div>

  {/* Conditional elements */}
  {hasPermission('delivery:excel_import_delivery') && (
    <>
      {/* Driver filter */}
      <Select
        placeholder="🚗 Жолооч"
        style={{ width: 200 }}
        allowClear
        showSearch
        optionFilterProp="children"
        onChange={handleDriverFilterChange}
        onDropdownVisibleChange={(open) => {
          if (open) fetchDrivers();
        }}
      >
        {drivers.map((driver) => (
          <Option key={driver.id} value={driver.id}>
            {driver.username || `Driver #${driver.id}`}
          </Option>
        ))}
      </Select>

      {/* Merchant filter */}
      <Select
        placeholder="🏪 Дэлгүүр"
        style={{ width: 200 }}
        allowClear
        showSearch
        optionFilterProp="children"
        onChange={handleMerchantFilterChange}
        onDropdownVisibleChange={(open) => {
          if (open) fetchMerchant();
        }}
      >
        {merchs.map((merchant) => (
          <Option key={merchant.id} value={merchant.id}>
            {merchant.username || `Merchant #${merchant.id}`}
          </Option>
        ))}
      </Select>

      {/* Import Excel Button */}
      <div
        onClick={() => fileInputRef.current?.click()}
        onDragOver={(e) => e.preventDefault()}
        onDrop={handleDrop}
        style={{
          padding: '8px 16px',
          border: '1px dashed #52c41a',
          borderRadius: '6px',
          backgroundColor: '#f6ffed',
          color: '#389e0d',
          fontWeight: 500,
          fontSize: 14,
          cursor: 'pointer',
          whiteSpace: 'nowrap',
        }}
      >
        📂 Excel Импорт
      </div>

      <input
        ref={fileInputRef}
        type="file"
        accept=".xlsx, .xls"
        style={{ display: 'none' }}
        onChange={handleExcelImport}
      />
    </>
  )}

  {/* Always show Add Delivery button */}
  <div style={{ marginLeft: 'auto' }}>
    <Button type="primary" onClick={handleDeliveryButton}>
      + Хүргэлт нэмэх
    </Button>
  </div>
</Space>


          <Table
  rowSelection={rowSelection}
  columns={columns}
  dataSource={deliveryData}
  rowKey="id"
  pagination={{
    current: pagination.current,
    pageSize: pagination.pageSize,
    total: pagination.total,
    showSizeChanger: true,
    pageSizeOptions: [ '100', '500', '1000'], // Add this line
    onChange: (page, pageSize) => {
      setPagination((prev) => ({
        ...prev,
        current: page,
        pageSize: pageSize,
      }));
    },
  }}
  
expandable={{
  expandedRowRender: (record) => {
    if (loadingRows.includes(record.id)) {
      return <p>Loading items...</p>;
    }
    const items = expandedItems[record.id];
    if (!items || items.length === 0) return <p>No items found.</p>;

    const columns = [
      {
        dataIndex: ['good', 'name'],
        key: 'name',
        render: (text: string | undefined) => text || '-',
      },
      {
        dataIndex: 'quantity',
        key: 'quantity',
      },
    ];    

    return (
      <Table
        columns={columns}
        dataSource={items}
        pagination={false}
        rowKey="id"
        size="small"
        bordered
      />
    );
  },
  expandedRowKeys,
  onExpand: handleExpand,
  expandRowByClick: false,
}}
/>

<Drawer
  title="Хүргэлт үүсгэх"
  placement="right"
  visible={isDrawerVisible}
  onClose={handleCloseDrawer}
  width={500}  // wider drawer
  bodyStyle={{ padding: '20px' }}
>
  <Form form={form}  initialValues={{ merchantId: selectedMerchantId }}
   layout="vertical">
    {/* Merchant, phone, address, price (total), comment ... */}

    {isMerchant ? (
    <>
      <Form.Item>
        <div style={{
          padding: '4px 11px',
          border: '1px solid #d9d9d9',
          borderRadius: 2,
          backgroundColor: '#f5f5f5',
          color: 'rgba(0, 0, 0, 0.85)',
          minHeight: 25,
        }}>
          {username}
        </div>
      </Form.Item>

      <Form.Item name="merchantId" hidden>
        <Input type="hidden" value={selectedMerchantId} />
      </Form.Item>
    </>
  ) : (
  <Form.Item
  label="Дэлгүүрийн нэр"
  name="merchantId"
  rules={[{ required: true, message: 'Please select a merchant!' }]}
>
  <Select
    placeholder="Select a merchant"
    value={selectedMerchantId}
    onChange={(value) => setSelectedMerchantId(value)}
    showSearch
    filterOption={(input, option) => {
      if (!option || !option.children) return false;
      
      // Convert children to string safely
      const text = Array.isArray(option.children) 
        ? option.children.join('')
        : String(option.children);
      
      return text.toLowerCase().includes(input.toLowerCase());
    }}
    optionFilterProp="children"
  >
    {merchants.map((merchant) => (
      <Select.Option key={merchant.id} value={merchant.id}>
        {merchant.username}
      </Select.Option>
    ))}
  </Select>
</Form.Item>
  )}
    <Form.Item
      label="Утас"
      name="phone"
      rules={[{ required: true, message: 'Please input the phone number!' }]}
    >
      <Input placeholder="Enter phone number" />
    </Form.Item>

    <Form.Item
      label="Хаяг"
      name="address"
      rules={[{ required: true, message: 'Please input the address!' }]}
    >
      <Input placeholder="Enter address" />
    </Form.Item>

    <Form.Item
  label="Үнэ"
  name="price"
>
  <InputNumber
    placeholder="Үнэ оруулах"
    min={0}
    style={{ width: '100%' }}
    onKeyPress={(e) => {
      // block letters, only allow numbers and dot
      if (!/[0-9]/.test(e.key)) {
        e.preventDefault();
      }
    }}
  />
</Form.Item>


    <Form.Item
      label="Тайлбар"
      name="comment"
    >
      <Input placeholder="Enter comment" />
    </Form.Item>

    <Form.Item>
      <Button type="primary" onClick={handleOk} block>
        Үүсгэх
      </Button>
    </Form.Item>

    <Form.Item>
        <Checkbox checked={pullFromWarehouse} onChange={handleCheckboxChange}>
          Агуулахаас бараа татах?
        </Checkbox>
      </Form.Item>

    {pullFromWarehouse && (
      <>
        <Row gutter={8} style={{ marginBottom: 10 }}>
          <Col span={8}>
          <Select
          value={selectedProduct}
          placeholder="Бараа сонгох"
          onChange={setSelectedProduct}
          style={{ width: '100%' }}
        >
          {products.map(p => (
            <Option key={p.id} value={p.id}>{p.name}</Option>
          ))}
        </Select>

          </Col>

          <Col span={6}>
            <InputNumber
              min={1}
              value={quantity}
              onChange={value => setQuantity(value || 1)}
              style={{ width: '100%' }}
              placeholder="Тоо ширхэг"
            />
          </Col>

          <Col span={6}>
            <InputNumber
              min={0}
              value={productPrice}
              onChange={value => setProductPrice(value || 0)}
              style={{ width: '100%' }}
              placeholder="Үнэ"
              formatter={value => `${value} ₮`}
              parser={value => {
                if (!value) return 0; // Return 0 when empty
                const numericString = value.replace(/₮\s?|(,*)/g, '');
                return Number(numericString);
              }}
                      />
          </Col>

          <Col span={4}>
            <Button
              type="primary"
              onClick={handleAddProduct}
              icon={<PlusOutlined />}
              block
            />
          </Col>
        </Row>

        <List
  bordered
  size="small"
  locale={{ emptyText: 'Бараа нэмэгдээгүй' }}
  dataSource={productList}
  renderItem={item => (
    <List.Item
      actions={[
        <Button
          danger
          size="small"
          icon={<DeleteOutlined />}
          onClick={() => handleDeleteProduct(item.productId)}
        />
      ]}
    >
      <strong>{item.productName}</strong> - {item.quantity} ширхэг - {item.price.toLocaleString()} ₮
    </List.Item>
  )}
/>

      </>
    )}
  </Form>
</Drawer>
      {/* Fixed Bottom Section */}
      {hasPermission('delivery:excel_import_delivery') && (

      <div style={{ position: 'fixed', bottom: 0, left: 0, width: '100%', background: '#fff', padding: '16px 24px', borderTop: '1px solid #ddd', zIndex: 999 }}>
        <Space style={{ marginRight: 16 }}>
         <div>
        {selectedRowKeys.length} item(s) selected
        {selectedRowKeys.length > 0 && (
         <span style={{ marginLeft: '16px', fontWeight: 'bold', color: '#1890ff' }}>
  Total:{' '}
  {deliveryData
    .filter(item => selectedRowKeys.includes(item.id))
    .reduce((sum, item) => sum + Number(item.price || 0), 0)
    .toLocaleString()}{' '}
  ₮
</span>

        )}
      </div>
          <Button
            type="primary"
            onClick={handleAllocateToDriver}
            disabled={selectedRowKeys.length === 0}
          >
            Жолоочид хуваарилах
          </Button>
          <Button
            type="primary"
            onClick={handleDelete}
            disabled={selectedRowKeys.length === 0}
          >
            Устгах
          </Button>
          <Button
            type="primary"
            onClick={handleStatus}
            disabled={selectedRowKeys.length === 0}
          >
            Төлөв солих
          </Button>
          <Button
  type="primary"
              disabled={selectedRowKeys.length === 0}

onClick={() => {
  // 1. Filter out the selected rows based on selectedRowKeys
  const selectedRows = deliveryData.filter(item =>
    selectedRowKeys.includes(item.id)
  );

  // 2. Debug: log selected data in console
  console.log('Selected rows:', selectedRows);

  // 3. Open a new blank window to write printable content
  const printWindow = window.open('', '_blank');
  if (printWindow) {
    // Start HTML structure
    printWindow.document.write('<html><head><title>Print</title>');

    // Optional: Add basic styles for table
    printWindow.document.write(`
      <style>
        table {
          width: 100%;
          border-collapse: collapse;
          margin-top: 20px;
          font-family: Arial, sans-serif;
        }
        th, td {
          border: 1px solid #ccc;
          padding: 8px;
          text-align: left;
        }
        th {
          background-color: #f5f5f5;
        }
      </style>
    `);

    printWindow.document.write('</head><body>');
    printWindow.document.write('<h3>Хүргэлтүүд</h3>');

    // 4. Build the table headers
    printWindow.document.write(`
      <table>
        <thead>
          <tr>
            <th>ID</th>

            <th>Merchant</th>
            <th>Address</th>
            <th>Phone</th>
            <th>Price</th>
            <th>Comment</th>
          </tr>
        </thead>
        <tbody>
    `);

    // 5. Populate table rows with selected data
    selectedRows.forEach(row => {
      printWindow.document.write(`
        <tr>
          <td>${row.id}</td>

          <td>${row.merchant?.username ?? '-'}</td>
          <td>${row.address}</td>
          <td>${row.phone}</td>
          <td>${row.price}</td>
          <td>${row.comment ?? '-'}</td>
        </tr>
      `);
    });

    // 6. Close table and HTML structure
    printWindow.document.write('</tbody></table>');
    printWindow.document.write('</body></html>');
    printWindow.document.close();

    // 7. Trigger print
    printWindow.print();
  }
}}

>
  Print Selected
</Button>
<Button
  type="default"
  disabled={selectedRowKeys.length === 0}
  onClick={() => {
    const selectedRows = deliveryData.filter(item =>
      selectedRowKeys.includes(item.id)
    );

    // Status mapping (id => status text)
    const statusMap = {
      1: "шинэ",
      2: "жолоочид",
      3: "хүргэлтэнд",
      4: "буцаасан",
      5: "цуцалсан",
      6: "ирээгүй бараа",
      7: "ухарсан",
      8: "утсаа аваагүй",
    };

    // Prepare data for Excel
   // Prepare data for Excel
const excelData = selectedRows.map(row => ({
  'ID': row.id,
  'Дэлгүүр': row.merchant?.username ?? '-',
  'Хаяг': row.address,
  'Утас': row.phone,
  // ✅ convert price to number
  'Үнэ': Number(row.price) || 0,
  'Тайлбар': row.comment ?? '-',
  'Статус': statusMap[Number(row.status) as keyof typeof statusMap] ?? row.status,
}));


    // Convert to worksheet
    const worksheet = XLSX.utils.json_to_sheet(excelData);

    // Create workbook and add worksheet
    const workbook = XLSX.utils.book_new();
    XLSX.utils.book_append_sheet(workbook, worksheet, 'Selected Deliveries');

    // Export Excel file
    XLSX.writeFile(workbook, 'selected_deliveries.xlsx');
  }}
  style={{ marginLeft: 8 }}
>
  Export Excel
</Button>

        </Space>
        
      </div>
      )}
     <Modal
  title="Select Driver:"
  visible={isModalVisible}
onCancel={() => {
  setIsModalVisible(false);
  setDeliveryDate(dayjs()); // Reset to today when canceling
}}
  onOk={handleSaveAllocation}
  okText="Save"
  cancelText="Cancel"
>
  <Space direction="vertical" style={{ width: '100%' }} size="large">
    
    <div>
     
      <Select
        style={{ width: '100%' }}
        placeholder="Select a driver"
        onChange={handleDriverSelection}
        value={selectedDriverId}
      >
        {drivers.map((driver) => (
          <Option key={driver.id} value={driver.id}>
            {driver.username}
          </Option>
        ))}
      </Select>
    </div>
  </Space>
</Modal>
      <Modal
        title="Select status"
        visible={isStatusModal}
        onCancel={() => setIsStatusModal(false)}
        onOk={handeStatusChange}
        okText="Save"
        cancelText="Cancel"
      >
        <Select
          style={{ width: '100%' }}
          placeholder="Select a status"
          onChange={handleStatusSelection}
          value={selectStatusId}
        >
          {status.map((stat) => (
            <Option key={stat.id} value={stat.id}>
              {stat.status}
            </Option>
          ))}
        </Select>
      </Modal>
    <Modal
  title="Edit Phone & Address"
  visible={isEditModal}
  onOk={handleEdit}
  onCancel={handleCancel}
  okText="Save"
  cancelText="Cancel"
>
  <Form form={form} layout="vertical">
    <Form.Item name="phone" label="Phone" rules={[{ required: true, message: 'Please enter phone number' }]}>
      <Input />
    </Form.Item>
    <Form.Item name="address" label="Address" rules={[{ required: true, message: 'Please enter address' }]}>
      <Input />
    </Form.Item>
    {/* Add price field */}
  <Form.Item name="price" label="Price">
  <InputNumber
    min={0}
    style={{ width: '100%' }}
    addonAfter="₮"
  />
</Form.Item>
  </Form>
</Modal>
<Modal
  title="Delivery Image"
  visible={isImageModalVisible}
  onCancel={handleCloseImageModal}
  footer={[
    <Button key="close" onClick={handleCloseImageModal}>
      Close
    </Button>
  ]}
  width={800}
>
  {selectedImageUrl && (
    <div style={{ textAlign: 'center' }}>
      <img
        src={selectedImageUrl}
        alt="Delivery"
        style={{ 
          maxWidth: '100%', 
          maxHeight: '500px',
          borderRadius: '8px',
          boxShadow: '0 4px 8px rgba(0,0,0,0.1)'
        }}
      />
      <div style={{ marginTop: '16px' }}>
        <Button 
          type="primary" 
          onClick={() => window.open(selectedImageUrl, '_blank')}
        >
          Open in New Tab
        </Button>
      </div>
    </div>
  )}
</Modal>
    </div>
  );
}