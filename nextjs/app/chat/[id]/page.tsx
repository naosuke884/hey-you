import { FC } from 'react';

interface ChatPageProps {
  params: {
    id: string;
  };
};

const ChatPage: FC<ChatPageProps> = async ({ params }) => {
  return (
    <div>
      <h1>Chat Page</h1>
      <p>これは のchat ページです。</p>
    </div>
  );
}

export default ChatPage;