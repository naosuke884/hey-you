type ChatPageProps = {
  params: {
    id: string;
  };
};

export default async function ChatPage({ params }: ChatPageProps) {
  const { id } = await params;
  return (
    <div>
      <h1>Chat Page</h1>
      <p>これは {id} のchat ページです。</p>
    </div>
  );
}