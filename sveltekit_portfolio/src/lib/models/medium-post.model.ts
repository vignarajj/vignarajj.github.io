// Model for Medium posts parsed from RSS feed
export interface MediumPost {
  title: string;
  link: string;
  pubDate?: Date;
}

// Note: Date parsing from RSS should be handled in the data fetching logic. 