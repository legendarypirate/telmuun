export interface Good {
  name: string;
}

export interface DeliveryItem {
  id: number;
  good_id: number;
  quantity: number;
  good?: Good;
}

export interface User {
  id: number;
  username: string;
  phone?: string;
  email?: string;
  role?: number;
  role_id?: number;
}

export interface Delivery {
  id: number;
  merchant_id?: number;
  phone: string;
  address: string;
  status: number | string;
  price: number;
  comment: string;
  driver_comment?: string;
  driver?: { username: string } | null;
  createdAt: string;
  delivered_at?: string;
  delivery_date?: string;
  district_id?: number | null;
  merchant?: {
    id?: number;
    username: string;
    report_price?: number;
  };
  status_name?: {
    status: string;
    color: string;
  };
  items?: DeliveryItem[];
}
